// frontend/src/app/features/auth/components/login/login.component.spec.ts
import { ComponentFixture, TestBed, fakeAsync, tick } from '@angular/core/testing';
import { ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { AuthService } from '../../../../core/services/auth.service';
import { of, throwError } from 'rxjs';
import { Component } from '@angular/core';
import { LoginComponent } from './login.component';

// DummyComponent para rutas
@Component({
  standalone: true,
  template: '',
})
class DummyComponent {}

describe('LoginComponent', () => {
  const dummyUser = {
    usuarioID: 1,
    nombreUsuario: 'user',
    email: 'test@example.com',
    twoFAEnabled: false,
    fechaRegistro: '2025-05-20T00:00:00.000Z',
    activo: true,
  };

  let fixture: ComponentFixture<LoginComponent>;
  let component: LoginComponent;
  let authSpy: jasmine.SpyObj<AuthService>;
  let router: Router;

  beforeEach(async () => {
    // Incluimos setUser en el spy
    const spy = jasmine.createSpyObj('AuthService', ['login', 'login2FA', 'setUser']);

    await TestBed.configureTestingModule({
      imports: [
        LoginComponent,
        ReactiveFormsModule,
        RouterTestingModule.withRoutes([
          { path: 'dashboard', component: DummyComponent }
        ]),
        DummyComponent,
      ],
      providers: [
        { provide: AuthService, useValue: spy }
      ],
    }).compileComponents();

    fixture = TestBed.createComponent(LoginComponent);
    component = fixture.componentInstance;
    authSpy = TestBed.inject(AuthService) as jasmine.SpyObj<AuthService>;
    router = TestBed.inject(Router);
    spyOn(router, 'navigate');

    // Limpiamos cualquier token previo
    localStorage.clear();

    fixture.detectChanges();
  });

  it('debe crearse', () => {
    expect(component).toBeTruthy();
  });

  it('loginInitial: si el servicio devuelve LOGIN_OK navega a /dashboard', fakeAsync(() => {
    authSpy.login.and.returnValue(of({
      token: 'LOGIN_OK',
      user: dummyUser,
    }));

    component.loginForm.setValue({
      nombreUsuario: 'user',
      password: 'pass',
      verificationCode: ''
    });

    component.onSubmit();
    tick();

    expect(authSpy.login).toHaveBeenCalledWith('user', 'pass');
    expect(authSpy.setUser).toHaveBeenCalledWith(dummyUser);
    expect(router.navigate).toHaveBeenCalledWith(['/dashboard']);
  }));

  it('loginInitial: si el servicio devuelve 2FA_REQUIRED debe pedir código', fakeAsync(() => {
    authSpy.login.and.returnValue(of({
      token: '2FA_REQUIRED',
      user: dummyUser,
    }));

    component.loginForm.setValue({
      nombreUsuario: 'user',
      password: 'pass',
      verificationCode: ''
    });

    component.onSubmit();
    tick();

    expect(component.twoFactorRequired).toBeTrue();
    expect(component.nombreUsuario).toBe('user');
    expect(component.loginForm.get('password')?.disabled).toBeTrue();
  }));

  it('loginInitial: si hay error muestra mensaje de credenciales inválidas', fakeAsync(() => {
    authSpy.login.and.returnValue(throwError(() => new Error('401')));

    component.loginForm.setValue({
      nombreUsuario: 'x',
      password: 'y',
      verificationCode: ''
    });

    component.onSubmit();
    tick();

    expect(component.errorMessage).toBe('Credenciales inválidas o usuario inactivo');
  }));

  it('loginWith2FA: código correcto almacena token y navega', fakeAsync(() => {
    component.twoFactorRequired = true;
    component.nombreUsuario = 'user2';
    component.loginForm.get('verificationCode')?.setValue('123456');

    const fakeResponse = {
      token: 'ABC',
      user: dummyUser,
    };
    authSpy.login2FA.and.returnValue(of(fakeResponse));

    component.onSubmit();
    tick();

    expect(authSpy.login2FA).toHaveBeenCalledWith('user2', '123456');
    expect(localStorage.getItem('token')).toBe('ABC');
    expect(authSpy.setUser).toHaveBeenCalledWith(dummyUser);
    expect(router.navigate).toHaveBeenCalledWith(['/dashboard']);
  }));

  it('loginWith2FA: código incorrecto muestra error', fakeAsync(() => {
    component.twoFactorRequired = true;
    component.nombreUsuario = 'user2';
    component.loginForm.get('verificationCode')?.setValue('000000');
    authSpy.login2FA.and.returnValue(throwError(() => new Error('401')));

    component.onSubmit();
    tick();

    expect(component.errorMessage).toBe('Código 2FA incorrecto');
  }));
});

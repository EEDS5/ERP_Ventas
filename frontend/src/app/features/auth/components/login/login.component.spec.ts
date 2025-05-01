// frontend/src/app/features/auth/components/login/login.component.spec.ts
import { ComponentFixture, TestBed, fakeAsync, tick } from '@angular/core/testing';
import { LoginComponent } from './login.component';
import { ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { AuthService } from '../../../../core/services/auth.service';
import { of, throwError } from 'rxjs';
import { Component } from '@angular/core';

// DummyComponent as standalone for route tests
@Component({
  standalone: true,
  template: ''
})
class DummyComponent {}

describe('LoginComponent', () => {
  let fixture: ComponentFixture<LoginComponent>;
  let component: LoginComponent;
  let authSpy: jasmine.SpyObj<AuthService>;
  let router: Router;

  beforeEach(async () => {
    const spy = jasmine.createSpyObj('AuthService', ['login', 'login2FA']);

    await TestBed.configureTestingModule({
      imports: [
        LoginComponent,          // componente standalone
        ReactiveFormsModule,
        RouterTestingModule.withRoutes([
          { path: 'dashboard', component: DummyComponent }
        ]),
        DummyComponent           // import DummyComponent as standalone
      ],
      providers: [
        { provide: AuthService, useValue: spy }
      ]
    }).compileComponents();

    fixture = TestBed.createComponent(LoginComponent);
    component = fixture.componentInstance;
    authSpy = TestBed.inject(AuthService) as jasmine.SpyObj<AuthService>;
    router = TestBed.inject(Router);
    spyOn(router, 'navigate');
    fixture.detectChanges();
  });

  it('debe crearse', () => {
    expect(component).toBeTruthy();
  });

  it('loginInitial: si el servicio devuelve LOGIN_OK navega a /dashboard', fakeAsync(() => {
    authSpy.login.and.returnValue(of('LOGIN_OK'));
    component.loginForm.setValue({ nombreUsuario: 'user', password: 'pass', verificationCode: '' });

    component.onSubmit();
    tick();

    expect(authSpy.login).toHaveBeenCalledWith('user', 'pass');
    expect(router.navigate).toHaveBeenCalledWith(['/dashboard']);
  }));

  it('loginInitial: si el servicio devuelve 2FA_REQUIRED debe pedir código', fakeAsync(() => {
    authSpy.login.and.returnValue(of('2FA_REQUIRED'));
    component.loginForm.setValue({ nombreUsuario: 'user', password: 'pass', verificationCode: '' });

    component.onSubmit();
    tick();

    expect(component.twoFactorRequired).toBeTrue();
    expect(component.nombreUsuario).toBe('user');
    expect(component.loginForm.get('password')?.disabled).toBeTrue();
  }));

  it('loginInitial: si hay error muestra mensaje de credenciales inválidas', fakeAsync(() => {
    authSpy.login.and.returnValue(throwError(() => new Error('401')));
    component.loginForm.setValue({ nombreUsuario: 'x', password: 'y', verificationCode: '' });

    component.onSubmit();
    tick();

    expect(component.errorMessage).toBe('Credenciales inválidas o usuario inactivo');
  }));

  it('loginWith2FA: código correcto almacena token y navega', fakeAsync(() => {
    component.twoFactorRequired = true;
    component.nombreUsuario = 'user2';
    component.loginForm.get('verificationCode')?.setValue('123456');
    const fakeToken = { token: 'ABC' };
    authSpy.login2FA.and.returnValue(of(fakeToken));

    component.onSubmit();
    tick();

    expect(authSpy.login2FA).toHaveBeenCalledWith('user2', '123456');
    expect(localStorage.getItem('token')).toBe('ABC');
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

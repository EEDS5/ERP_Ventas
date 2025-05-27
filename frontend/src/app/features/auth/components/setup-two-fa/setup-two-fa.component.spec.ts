import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { RouterTestingModule } from '@angular/router/testing';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import { NoopAnimationsModule } from '@angular/platform-browser/animations';

import { SetupTwoFaComponent } from './setup-two-fa.component';

describe('SetupTwoFaComponent', () => {
  let component: SetupTwoFaComponent;
  let fixture: ComponentFixture<SetupTwoFaComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [
        SetupTwoFaComponent,
        HttpClientTestingModule,
        RouterTestingModule,
        MatSnackBarModule,
        NoopAnimationsModule
      ]
    }).compileComponents();

    fixture = TestBed.createComponent(SetupTwoFaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

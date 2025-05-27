import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpClientTestingModule }   from '@angular/common/http/testing';
import { RouterTestingModule }       from '@angular/router/testing';
import { MatSnackBarModule }         from '@angular/material/snack-bar';
import { NoopAnimationsModule }      from '@angular/platform-browser/animations';

import { VerifyTwoFaComponent } from './verify-two-fa.component';

describe('VerifyTwoFaComponent', () => {
  let component: VerifyTwoFaComponent;
  let fixture: ComponentFixture<VerifyTwoFaComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [
        VerifyTwoFaComponent,
        HttpClientTestingModule,
        RouterTestingModule,
        MatSnackBarModule,
        NoopAnimationsModule
      ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(VerifyTwoFaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

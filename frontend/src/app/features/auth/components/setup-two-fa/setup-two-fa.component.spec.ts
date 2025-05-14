import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SetupTwoFaComponent } from './setup-two-fa.component';

describe('SetupTwoFaComponent', () => {
  let component: SetupTwoFaComponent;
  let fixture: ComponentFixture<SetupTwoFaComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SetupTwoFaComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SetupTwoFaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

// frontend/src/app/features/profile/pages/components/profile/change-password-dialog.component.ts

import { Component, ChangeDetectionStrategy, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatDialogRef, MatDialogModule } from '@angular/material/dialog';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { TranslateModule, TranslateService } from '@ngx-translate/core';
import { HttpErrorResponse } from '@angular/common/http';
import { ProfileService } from '@core/services/profile.service';

@Component({
  selector: 'app-change-password-dialog',
  standalone: true,
  styleUrls: ['./change-password-dialog.component.scss'],
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatDialogModule,
    MatSnackBarModule,
    TranslateModule,
  ],
  template: `
    <h2 mat-dialog-title>{{ 'change_password' | translate }}</h2>

    <mat-dialog-content class="dialog-content-wrapper" [formGroup]="passwordForm">
      <mat-form-field appearance="outline" class="form-field-full">
        <mat-label>{{ 'current_password' | translate }}</mat-label>
        <input matInput type="password" formControlName="currentPassword" />
        <mat-error *ngIf="passwordForm.get('currentPassword')?.hasError('required')">
          {{ 'current_password_required' | translate }}
        </mat-error>
      </mat-form-field>

      <mat-form-field appearance="outline" class="form-field-full">
        <mat-label>{{ 'new_password' | translate }}</mat-label>
        <input matInput type="password" formControlName="newPassword" />
        <mat-error *ngIf="passwordForm.get('newPassword')?.hasError('required')">
          {{ 'new_password_required' | translate }}
        </mat-error>
        <mat-error *ngIf="passwordForm.get('newPassword')?.hasError('minlength')">
          {{
            'new_password_min_length'
              | translate:{ number: passwordForm.get('newPassword')?.errors?.['minlength']?.requiredLength }
          }}
        </mat-error>
      </mat-form-field>

      <mat-form-field appearance="outline" class="form-field-full">
        <mat-label>{{ 'confirm_password' | translate }}</mat-label>
        <input matInput type="password" formControlName="confirmPassword" />
        <mat-error *ngIf="passwordForm.get('confirmPassword')?.hasError('required')">
          {{ 'confirm_password_required' | translate }}
        </mat-error>
        <mat-error
          *ngIf="
            passwordForm.get('confirmPassword')?.touched &&
            passwordForm.get('newPassword')?.value !== passwordForm.get('confirmPassword')?.value
          "
        >
          {{ 'passwords_mismatch' | translate }}
        </mat-error>
      </mat-form-field>
    </mat-dialog-content>

    <mat-dialog-actions align="end">
      <button mat-button type="button" (click)="onCancel()">
        {{ 'cancel' | translate }}
      </button>
      <button mat-raised-button color="primary" type="button" (click)="onSubmit()">
        {{ 'update_password' | translate }}
      </button>
    </mat-dialog-actions>
  `,
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ChangePasswordDialogComponent {
  private fb = inject(FormBuilder);
  private profileService = inject(ProfileService);
  private dialogRef = inject(MatDialogRef<ChangePasswordDialogComponent>);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  public passwordForm = this.fb.group({
    currentPassword: ['', Validators.required],
    newPassword: ['', [Validators.required, Validators.minLength(6)]],
    confirmPassword: ['', Validators.required],
  });

  onCancel(): void {
    this.dialogRef.close();
  }

  onSubmit(): void {
    if (this.passwordForm.invalid) {
      this.passwordForm.markAllAsTouched();
      this.snackBar.open(
        this.translate.instant('form_errors'),
        this.translate.instant('cancel'),
        { duration: 3000 }
      );
      return;
    }

    const currentPassword = this.passwordForm.get('currentPassword')!.value!;
    const newPassword = this.passwordForm.get('newPassword')!.value!;
    const confirmPassword = this.passwordForm.get('confirmPassword')!.value!;

    if (newPassword !== confirmPassword) {
      this.snackBar.open(
        this.translate.instant('passwords_mismatch'),
        this.translate.instant('cancel'),
        { duration: 3000 }
      );
      return;
    }

    this.profileService.updateMyPassword({ currentPassword, newPassword }).subscribe({
      next: () => {
        this.snackBar.open(
          this.translate.instant('password_update_success'),
          this.translate.instant('cancel'),
          { duration: 3000 }
        );
        this.dialogRef.close();
      },
      error: (error: unknown) => {
        const msgKey =
          error instanceof HttpErrorResponse && (error.status === 400 || error.status === 401)
            ? 'current_password_incorrect'
            : 'password_update_error';
        this.snackBar.open(
          this.translate.instant(msgKey),
          this.translate.instant('cancel'),
          { duration: 3000 }
        );
      },
    });
  }
}

[Setup]
AppName=Net Interop
AppVersion=1.0
WizardStyle=modern
DefaultDirName={autopf}\Program
DisableProgramGroupPage=yes
DisableWelcomePage=no

[Files]
Source: "..\NetDll\NetDll\bin\Debug\net4.5\x86\NetDll.dll"; DestDir: "{app}"; Flags: dontcopy
Source: "..\NetDll\NetDll\bin\Debug\net4.5\x86\NetDll.pdb"; DestDir: "{app}"; Flags: dontcopy

[Code]

procedure UpdateInt(var value: Integer);
external 'UpdateInt@files:NetDll.dll stdcall';

procedure UpdateString(var value: WideString);
external 'UpdateString@files:NetDll.dll stdcall';

procedure InitializeWizard;
var
  intValue: Integer;
  stringValue: WideString;
begin
  try
   // UpdateInt
   intValue := 20;
   UpdateInt(intValue);
   if (intValue <> 21) then RaiseException('UpdateInt failed');
   // UpdateString
   stringValue := 'value';
   UpdateString(stringValue);
   if (stringValue <> 'value (updated)') then RaiseException('UpdateString failed');
  except
    Log('Error calling NetDll: ' + AddPeriod(GetExceptionMessage));
    Abort();
  end;
end;
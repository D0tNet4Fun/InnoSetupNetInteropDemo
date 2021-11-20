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

type
  ComplexType = record
    StringValue: WideString;
    IntValue: Integer;
  end;

procedure UpdateInt(var value: Integer);
external 'UpdateInt@files:NetDll.dll stdcall';

procedure UpdateString(var value: WideString);
external 'UpdateString@files:NetDll.dll stdcall';

procedure UpdateComplexType(var value: ComplexType);
external 'UpdateComplexType@files:NetDll.dll stdcall';

procedure UpdateComplexTypeReference(var value: ComplexType);
external 'UpdateComplexTypeReference@files:NetDll.dll stdcall';

procedure GetComplexType(out value: ComplexType);
external 'GetComplexType@files:NetDll.dll stdcall';


procedure InitializeWizard;
var
  intValue: Integer;
  stringValue: WideString;
  complexValue: ComplexType;
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
   // UpdateComplexType
   complexValue.StringValue := 'value';
   complexValue.IntValue := 20;
   UpdateComplexType(complexValue);
   if ((complexValue.StringValue <> 'value (updated)') or (complexValue.IntValue <> 21)) then RaiseException('UpdateComplexType failed');
   // UpdateComplexTypeReference
   UpdateComplexTypeReference(complexValue);
   if ((complexValue.StringValue <> 'changed') or (complexValue.IntValue <> 40)) then RaiseException('UpdateComplexTypeReference failed');
   // GetComplexType
   GetComplexType(complexValue);
   if ((complexValue.StringValue <> 'new') or (complexValue.IntValue <> 1)) then RaiseException('GetComplexType failed');
  except
    Log('Error calling NetDll: ' + AddPeriod(GetExceptionMessage));
    Abort();
  end;
end;
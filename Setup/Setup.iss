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

procedure GetComplexTypeArray(out length: Integer; out value: array of ComplexType);
external 'GetComplexTypeArray@files:NetDll.dll stdcall';


procedure InitializeWizard;
var
  intValue: Integer;
  stringValue: WideString;
  complexValue: ComplexType;
  length: Integer;
  complexValues: array of ComplexType;
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
   // GetComplexTypeArray
   GetComplexTypeArray(length, complexValues);
   if (length <> 2) then RaiseException('GetComplexTypeArray failed (length)');
   complexValue := complexValues[0];
   if (complexValue.StringValue <> 'Item 1') or (complexValue.IntValue <> 1) then RaiseException('GetComplexTypeArray[0] failed');
   complexValue := complexValues[1];
   if (complexValue.StringValue <> 'Item 2') or (complexValue.IntValue <> 2) then RaiseException('GetComplexTypeArray[1] failed');

  except
    Log('Error calling NetDll: ' + AddPeriod(GetExceptionMessage));
    Abort();
  end;
end;
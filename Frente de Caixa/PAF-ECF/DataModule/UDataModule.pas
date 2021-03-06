{ *******************************************************************************
  Title: T2TiPDV
  Description: DataModule

  The MIT License

  Copyright: Copyright (C) 2012 T2Ti.COM

  Permission is hereby granted, free of charge, to any person
  obtaining a copy of this software and associated documentation
  files (the "Software"), to deal in the Software without
  restriction, including without limitation the rights to use,
  copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the
  Software is furnished to do so, subject to the following
  conditions:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  OTHER DEALINGS IN THE SOFTWARE.

  The author may be contacted at:
  alberteije@gmail.com

  @author T2Ti.COM
  @version 1.0
  ******************************************************************************* }
unit UDataModule;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Forms, ACBrBase, ACBrECF, FMTBcd, DB, memds, Classes, StdCtrls,
  Controls, Windows, ACBrPAF, ACBrSpedFiscal, ACBrSintegra, Dialogs, Inifiles,
  ACBrECFClass, ZConnection, ACBrEAD;

type

  { TFDataModule }

  TFDataModule = class(TDataModule)
    ACBrEAD: TACBrEAD;
    ACBrECF: TACBrECF;
    ACBrPAF: TACBrPAF;
    ACBrSintegra: TACBrSintegra;
    ACBrSpedFiscal: TACBrSPEDFiscal;
    procedure ACBrECFMsgPoucoPapel(Sender: TObject);
    procedure ACBrPAFPAFGetKeyRSA(var Chave: AnsiString);
  private
    { Private declarations }
  public
    { Public declarations }
    RemoteAppPath, BancoPAF: String;
  end;

var
  FDataModule: TFDataModule;

implementation

uses USplash, Biblioteca, UNotaFiscal;
{$R *.lfm}

procedure TFDataModule.ACBrECFMsgPoucoPapel(Sender: TObject);
begin
  //
end;

procedure TFDataModule.ACBrPAFPAFGetKeyRSA(var Chave: AnsiString);
begin
  Chave := '-----BEGIN RSA PRIVATE KEY-----' + sLineBreak +
           'MIICXQIBAAKBgQCodI47bNyjNmKa8A1BMDr0jR3ZpnQhHnF/y9Z5G/wwUsZKYZL6' + sLineBreak +
           'CzN7PylrtasCDDMLGDWwQbVP8JnduJwOTl2EvrYKSfUVkrf/YlKS7cRCWGbDXHF+' + sLineBreak +
           'LZ4Eshb1JAQTluiY/zk28FdBcUXpUA8Memvkstp69CPBULVXGSjToded9wIDAQAB' + sLineBreak +
           'AoGAdDZUmTJ01DQEupa4ziwTv/pKiYiHvQFfk6ZwA4UG6d9w5IeD+fQYRAJC9QeT' + sLineBreak +
           'PgpkfFbrUvlBuDBoNcnR/xyY7oiBovZdX8qYA2b2tMZKbU6P0FQHqcK0HZJqJ0Y9' + sLineBreak +
           'hQ4SmK8v4LbRSD+rzUHCyZ23pzD91eMKGtC7goUleiQo4WECQQDTJ80z7hXHTP+o' + sLineBreak +
           'Zb6+74amIP73+IIXcHZwzIhsLhbEXlEjlsmxYNrY3QE4Op+FWZJUtvbMKL2ve7tw' + sLineBreak +
           '/Ro/OAqlAkEAzDs1/zfRYyTMgBc00ehCP2QlQzOUF6O2lA0ay4NkJhgAadIgM7HZ' + sLineBreak +
           'FHUQVMzdSvLnE5KpF2ycPo2vT/nmlUWPawJAAyrKqie9DeM6xnTYOpbvJxjBmkiQ' + sLineBreak +
           '8vcN371BopXCY6mif+0oE1AHmE8gUI6Yi/B/AGRKKV/HEJXDhvtU5HPbvQJBALku' + sLineBreak +
           'dyeTVSiwlT0PzbUHBAq2o5LrkbxdlY9o0oL2ADkKSlWpUcmN2WfTPZumpoDu/teg' + sLineBreak +
           'g/HZaVLO5cd+sLVo/UECQQCfsxvunOswXJHp6JmLMSyN0rzvE4Mwy6PdART1KLtL' + sLineBreak +
           'CNQllWVutMNQOccb+f1afqoGOOj161UYPvLEYgpysOlN' + sLineBreak +
           '-----END RSA PRIVATE KEY-----';
end;

end.

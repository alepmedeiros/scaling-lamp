unit Unit1;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  System.Json,
  System.Math,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Vcl.Grids,
  Vcl.DBGrids;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    function amountfor(aType: String; aAudience: Integer) : Double;
    function playFor(aPlayId : String) : TJSONObject;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.amountfor(aType: String; aAudience: Integer): Double;
begin
  case IndexStr(aType, ['tragedy', 'comedy']) of
    0:
      begin
        result := 40000;
        if (aAudience > 30) then
          result := result + 1000 * (aAudience - 30);
      end;
    1:
      begin
        result := 30000;
        if (aAudience > 20) then
          result := result + 10000 + 500 * (aAudience - 20);

        result := result + 300 * aAudience;
      end;
  else
    raise Exception.Create('Type unknown ' + aType);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  lInvoice: TStrings;

  lInvoiceJson: TJsonArray;

  lJsonObj: TJsonObject;
  lja: TJsonArray;

  ltotalAmount: Double;
  lvolumeCredits: Double;
  lResult: String;
  I: Integer;
begin
  lInvoice := TStringList.Create;
  try
    lInvoice.LoadFromFile(Edit2.Text);

    lInvoiceJson := TJsonObject.ParseJSONValue
      (TEncoding.ASCII.GetBytes(lInvoice.Text), 0) as TJsonArray;

    lResult := Format('Statement for %s',
      [lInvoiceJson.Get(0).GetValue<String>('customer')]) + #13#10;

    lJsonObj := lInvoiceJson.Get(0) as TJsonObject;
    lja := lJsonObj.GetValue<TJsonArray>('performances') as TJsonArray;

    for I := 0 to Pred(lja.Size) do
    begin
      var
        lobj: TJsonObject;
      var
        vthisAmount: Double;

      lJsonObj := (lja.Items[I] as TJsonObject);
      lobj := (playFor(lJsonObj.GetValue<String>('playID')) as TJsonObject);

      vthisAmount := amountfor(lobj.GetValue<String>('type'),
        lJsonObj.GetValue<Integer>('audience'));

      // soma créditos por volume
      lvolumeCredits := lvolumeCredits + System.Math.Max(lJsonObj.GetValue<Integer>('audience') - 30, 0);
      // soma um crédito extra para cada dez espectadores de comédia
      if 'comedy' = lobj.GetValue<String>('type') then
        lvolumeCredits := lvolumeCredits + System.Math.Floor(lJsonObj.GetValue<Integer>('audience') / 5);

      // exibe a linha para esta requisição
      lResult := lResult + Format(' %s: %s (%u seats)',
        [lobj.GetValue<String>('name'), FormatFloat('#,##0.00',
        (vthisAmount / 100)), lJsonObj.GetValue<Integer>('audience')]) + #13#10;
      ltotalAmount := ltotalAmount + vthisAmount;
    end;

    lResult := lResult + Format('Amount owed is %s',
      [FormatFloat('#,##0.00', (ltotalAmount / 100))]) + #13#10;
    lResult := lResult + Format('You earned %n credits', [lvolumeCredits]
      ) + #13#10;

    Memo1.Lines.Add(lResult);
  finally
    lInvoice.DisposeOf;
  end;
end;

function TForm1.playFor(aPlayId: String): TJSONObject;
var
  lPlays: TStrings;
  lPlayJson: TJsonObject;
begin
  lPlays := TStringList.Create;
  try
    lPlays.LoadFromFile(Edit1.Text);
    lPlayJson := TJsonObject.ParseJSONValue
      (TEncoding.ASCII.GetBytes(lPlays.Text), 0) as TJsonObject;
  finally
    lPlays.DisposeOf;
  end;
  Result := lPlayJson.GetValue(aPlayId) as TJSONObject;
end;

end.

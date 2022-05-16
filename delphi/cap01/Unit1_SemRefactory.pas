unit Unit1_SemRefactory;

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
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  lPlays: TStrings;
  lInvoice: TStrings;

  lPlayJson: TJsonObject;
  lInvoiceJson: TJsonArray;

  lJsonObj: TJsonObject;
  lja: TJsonArray;

  ltotalAmount: Double;
  lvolumeCredits: Double;
  lResult: String;
  I: Integer;
begin
  lPlays := TStringList.Create;
  lInvoice := TStringList.Create;
  try
    lPlays.LoadFromFile(Edit1.Text);
    lInvoice.LoadFromFile(Edit2.Text);

    lPlayJson := TJsonObject.ParseJSONValue
      (TEncoding.ASCII.GetBytes(lPlays.Text), 0) as TJsonObject;

    lInvoiceJson := TJsonObject.ParseJSONValue
      (TEncoding.ASCII.GetBytes(lInvoice.Text), 0) as TJsonArray;

    lResult := Format('Statement for %s',
      [lInvoiceJson.Get(0).GetValue<String>('customer')]) + #13#10;

    lJsonObj := lInvoiceJson.Get(0) as TJsonObject;
    lja := lJsonObj.GetValue<TJsonArray>('performances') as TJsonArray;

    for I := 0 to Pred(lja.Size) do
    begin
      var
        ljobj, vResult: String;
      var
        lobj: TJsonObject;
      var
        vAudience: Integer;
      var
        vthisAmount: Double;

      lJsonObj := lja.Items[I] as TJsonObject;
      ljobj := lJsonObj.GetValue<String>('playID');

      lobj := lPlayJson.GetValue(ljobj) as TJsonObject;

      lobj.TryGetValue<String>('type', vResult);

      case IndexStr(vResult, ['tragedy', 'comedy']) of
        0:
          begin
            vthisAmount := 40000;
            if (lJsonObj.TryGetValue<Integer>('audience', vAudience)) and
              (vAudience > 30) then
              vthisAmount := vthisAmount + 1000 * (vAudience - 30);
          end;
        1:
          begin
            vthisAmount := 30000;
            if (lJsonObj.TryGetValue<Integer>('audience', vAudience)) and
              (vAudience > 20) then
              vthisAmount := vthisAmount + 10000 + 500 * (vAudience - 20);

            vthisAmount := vthisAmount + 300 * vAudience;
          end;
      else
        raise Exception.Create('Type unknown ' + vResult);
      end;

      // soma créditos por volume
      lvolumeCredits := lvolumeCredits + System.Math.Max(vAudience - 30, 0);
      // soma um crédito extra para cada dez espectadores de comédia
      if 'comedy' = vResult then
        lvolumeCredits := lvolumeCredits + System.Math.Floor(vAudience / 5);

      // exibe a linha para esta requisição
      lResult := lResult + Format(' %s: %s (%u seats)',
        [lobj.GetValue<String>('name'), FormatFloat('#,##0.00',
        (vthisAmount / 100)), vAudience]) + #13#10;
      ltotalAmount := ltotalAmount + vthisAmount;
    end;

    lResult := lResult + Format('Amount owed is %s',
      [FormatFloat('#,##0.00', (ltotalAmount / 100))]) + #13#10;
    lResult := lResult + Format('You earned %n credits', [lvolumeCredits]
      ) + #13#10;

    Memo1.Lines.Add(lResult);
  finally
    lPlays.DisposeOf;
    lInvoice.DisposeOf;
  end;
end;

end.

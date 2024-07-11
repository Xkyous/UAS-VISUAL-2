unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection, Grids, DBGrids, frxClass, frxDBSet;

type
  TForm1 = class(TForm)
    NIK: TLabel;
    NAMA: TLabel;
    TELP: TLabel;
    EMAIL: TLabel;
    ALAMAT: TLabel;
    MEMBER: TLabel;
    edtNik: TEdit;
    edtNama: TEdit;
    edtTelp: TEdit;
    edtEmail: TEdit;
    edtAlamat: TEdit;
    ComboBoxMember: TComboBox;
    DISKON: TLabel;
    TerisiOtomotis: TLabel;
    btnBaru: TButton;
    btnSimpan: TButton;
    btnEdit: TButton;
    btnHapus: TButton;
    btnBatal: TButton;
    dbgrd1: TDBGrid;
    MASUKANNAMA: TLabel;
    edtMasukanNama: TEdit;
    ZConnection1: TZConnection;
    ZKustomer: TZQuery;
    dsKustomer: TDataSource;
    CETAK: TButton;
    frxDBDataset1: TfrxDBDataset;
    frxReport1: TfrxReport;
    procedure btnBaruClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
    procedure dbgrd1CellClick(Column: TColumn);
    procedure btnHapusClick(Sender: TObject);
    procedure btnBatalClick(Sender: TObject);
    procedure ComboBoxMemberChange(Sender: TObject);
    procedure CETAKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  a: string;
implementation

{$R *.dfm}

procedure TForm1.btnBaruClick(Sender: TObject);
begin
  edtNik.Enabled := True;
  edtNama.Enabled := True;
  edtTelp.Enabled := True;
  edtEmail.Enabled := True;
  edtAlamat.Enabled := True;
  ComboBoxMember.Enabled := True;
  btnSimpan.Enabled := True;
  btnEdit.Enabled := False;
  btnHapus.Enabled := False;
end;

procedure TForm1.btnEditClick(Sender: TObject);
begin
  ZKustomer.SQL.Clear;
  ZKustomer.SQL.Add('UPDATE kustomer SET nik = :nik, nama = :nama, telp = :telp, email = :email, alamat = :alamat, member = :member WHERE id = :id');
  ZKustomer.Params.ParamByName('nik').AsString := edtNik.Text;
  ZKustomer.Params.ParamByName('nama').AsString := edtNama.Text;
  ZKustomer.Params.ParamByName('telp').AsString := edtTelp.Text;
  ZKustomer.Params.ParamByName('email').AsString := edtEmail.Text;
  ZKustomer.Params.ParamByName('alamat').AsString := edtAlamat.Text;
  ZKustomer.Params.ParamByName('member').AsString := ComboBoxMember.Text;
  ZKustomer.Params.ParamByName('id').AsString := a;
  ZKustomer.ExecSQL;

  ZKustomer.SQL.Clear;
  ZKustomer.SQL.Add('SELECT * FROM kustomer');
  ZKustomer.Open;
  ShowMessage('Data Berhasil Diupdate');
end;

procedure TForm1.btnSimpanClick(Sender: TObject);
begin
  ZKustomer.SQL.Clear;
  ZKustomer.SQL.Add('INSERT INTO kustomer (nik, nama, telp, email, alamat, member) VALUES ("' +
      edtNik.Text + '", "' + edtNama.Text + '", "' + edtTelp.Text + '", "' +
      edtEmail.Text + '", "' + edtAlamat.Text + '", "' + ComboBoxMember.Text + '")');
  ZKustomer.ExecSQL;

  ZKustomer.SQL.Clear;
  ZKustomer.SQL.Add('SELECT * FROM kustomer');
  ZKustomer.Open;

  ShowMessage('Data Berhasil Disimpan.');
end;

procedure TForm1.dbgrd1CellClick(Column: TColumn);
begin
  edtNik.Text := ZKustomer.Fields[1].AsString;
  edtNama.Text := ZKustomer.Fields[2].AsString;
  edtTelp.Text := ZKustomer.Fields[3].AsString;
  edtEmail.Text := ZKustomer.Fields[4].AsString;
  edtAlamat.Text := ZKustomer.Fields[5].AsString;
  ComboBoxMember.Text := ZKustomer.Fields[6].AsString;

  // Simpan ID untuk referensi pada update atau delete
  a := ZKustomer.Fields[0].AsString;

  // Mengaktifkan tombol Edit dan Hapus
  btnSimpan.Enabled := False;
  btnBaru.Enabled := False;
  btnBatal.Enabled := True;
  btnEdit.Enabled := True;
  btnHapus.Enabled := True;
end;

procedure TForm1.btnHapusClick(Sender: TObject);
begin
  ZKustomer.SQL.Clear;
  ZKustomer.SQL.Add('delete from kustomer WHERE id = "'+a+'"');
  ZKustomer.ExecSQL;

  ZKustomer.SQL.Clear;
  ZKustomer.SQL.Add('SELECT * FROM kustomer');
  ZKustomer.Open;
ShowMessage('Data Berhasil Dihapus');
end;

procedure TForm1.btnBatalClick(Sender: TObject);
begin
  edtNik.Clear;
  edtNama.Clear;
  edtTelp.Clear;
  edtEmail.Clear;
  edtAlamat.Clear;
  ComboBoxMember.ItemIndex := -1;
  btnBaru.Enabled := True;
  btnSimpan.Enabled := True;
  btnEdit.Enabled := True;
  btnHapus.Enabled := True;
end;

procedure TForm1.ComboBoxMemberChange(Sender: TObject);
begin
  if ComboBoxMember.Text = 'yes' then
  begin
    TerisiOtomotis.Caption := '10%';
  end
  else
  begin
    TerisiOtomotis.Caption := '5%';
  end;
end;

procedure TForm1.CETAKClick(Sender: TObject);
begin
  frxReport1.ShowReport()
end;

end.

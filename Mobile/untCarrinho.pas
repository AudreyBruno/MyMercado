unit untCarrinho;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox;

type
  TfrmCarrinho = class(TForm)
    LayoutCabecalho: TLayout;
    lblTitle: TLabel;
    imgVoltar: TImage;
    Layout1: TLayout;
    lblEnd: TLabel;
    Label1: TLabel;
    btnBuscar: TButton;
    Rectangle1: TRectangle;
    Layout2: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    Layout3: TLayout;
    Label4: TLabel;
    Label5: TLabel;
    Layout4: TLayout;
    Label6: TLabel;
    Label7: TLabel;
    Layout5: TLayout;
    Label8: TLabel;
    Label9: TLabel;
    ListBoxProdutosCarinho: TListBox;
    procedure FormShow(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
  private
    procedure AddProduto(id_produto: integer; descricao: string; qtd,
      valor_unit: double; foto: TStream);
    procedure CarregarCarinho;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCarrinho: TfrmCarrinho;

implementation

{$R *.fmx}

uses untPrincipal, untFrameProdutosLista;

procedure TfrmCarrinho.AddProduto(id_produto: integer; descricao: string; qtd, valor_unit: double; foto: TStream);
var
  item: TListBoxItem;
  frame: TfrmFrameProdutosLista;
begin
  item := TListBoxItem.Create(ListBoxProdutosCarinho);
  item.Selectable := False;
  item.Text := '';
  item.Height := 75;
  item.Tag := id_produto;

  //Frame
  frame := TfrmFrameProdutosLista.Create(item);
  //frame.imgProduto.Bitmap :=
  frame.lblDescricao.Text := descricao;
  frame.lblQtd.Text := qtd.ToString + ' x ' + FormatFloat('R$ #,##0.00', valor_unit);
  frame.lblPreco.Text := FormatFloat('R$ #,##0.00', qtd * valor_unit);

  item.AddObject(frame);
  ListBoxProdutosCarinho.AddObject(item);
end;

procedure TfrmCarrinho.CarregarCarinho;
begin
  AddProduto(1, 'Café Pilão Torrado E Moído - 100g', 6, 10, nil);
  AddProduto(2, 'Café Pilão Torrado E Moído - 200g', 5, 15, nil);
  AddProduto(3, 'Café Pilão Torrado E Moído - 300g', 4, 20, nil);
  AddProduto(4, 'Café Pilão Torrado E Moído - 400g', 3, 25, nil);
  AddProduto(5, 'Café Pilão Torrado E Moído - 500g', 2, 30, nil);
  AddProduto(6, 'Café Pilão Torrado E Moído - 600g', 1, 35, nil);
end;

procedure TfrmCarrinho.FormShow(Sender: TObject);
begin
  CarregarCarinho;
end;

procedure TfrmCarrinho.imgVoltarClick(Sender: TObject);
begin
  close;
end;

end.


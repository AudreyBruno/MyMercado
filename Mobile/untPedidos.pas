unit untPedidos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView;

type
  TfrmPedidos = class(TForm)
    LayoutCabecalho: TLayout;
    lblTitle: TLabel;
    imgVoltar: TImage;
    ListViewPedidos: TListView;
    procedure FormShow(Sender: TObject);
    procedure ListViewPedidosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure imgVoltarClick(Sender: TObject);
  private
    procedure AddPedidoLv(id_pedido, qtd_Itens: integer; nome, endereco, dt_pedido: string; vl_pedido: double);
    procedure ListarPedidos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPedidos: TfrmPedidos;

implementation

{$R *.fmx}

uses untPrincipal, untPedido;

procedure TfrmPedidos.AddPedidoLv(id_pedido, qtd_Itens: integer; nome, endereco, dt_pedido: string; vl_pedido: double);
var
  img: TListItemImage;
  txt: TListItemText;
begin
  with  ListViewPedidos.Items.Add do
    begin
      Height := 120;
      Tag := id_pedido;

      img := TListItemImage(Objects.FindDrawable('imgShop'));
      img.Bitmap := frmPrincipal.imgShop.Bitmap;

      txt := TListItemText(Objects.FindDrawable('txtNome'));
      txt.Text := nome;

      txt := TListItemText(Objects.FindDrawable('txtNumeroPedido'));
      txt.Text := 'Pedido' + id_pedido.ToString;

      txt := TListItemText(Objects.FindDrawable('txtEnd'));
      txt.Text := endereco;

      txt := TListItemText(Objects.FindDrawable('txtValor'));
      txt.Text := FormatFloat('R$ #,##0.00', vl_pedido) + ' - ' + qtd_Itens.ToString + ' itens';

      txt := TListItemText(Objects.FindDrawable('txtData'));
      txt.Text := dt_pedido;
    end;
end;

procedure TfrmPedidos.ListarPedidos;
begin
  AddPedidoLv(1, 5, 'P?o de A?ucar 1', 'Av. Paulista, 2689', '21/01/2023', 50);
  AddPedidoLv(2, 4, 'P?o de A?ucar 2', 'Av. Paulista, 2689', '22/01/2023', 40);
  AddPedidoLv(3, 3, 'P?o de A?ucar 3', 'Av. Paulista, 2689', '23/01/2023', 30);
  AddPedidoLv(4, 2, 'P?o de A?ucar 4', 'Av. Paulista, 2689', '24/01/2023', 20);
  AddPedidoLv(5, 1, 'P?o de A?ucar 5', 'Av. Paulista, 2689', '25/01/2023', 10);
end;

procedure TfrmPedidos.ListViewPedidosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  if not Assigned(frmPedido) then
    Application.CreateForm(TfrmPedido, frmPedido);

  frmPedido.Show;
end;

procedure TfrmPedidos.FormShow(Sender: TObject);
begin
  ListarPedidos;
end;

procedure TfrmPedidos.imgVoltarClick(Sender: TObject);
begin
  close;
end;

end.

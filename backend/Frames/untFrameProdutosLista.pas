unit untFrameProdutosLista;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Objects;

type
  TfrmFrameProdutosLista = class(TFrame)
    imgProduto: TImage;
    lblPreco: TLabel;
    lblQtd: TLabel;
    Layout1: TLayout;
    lblDescricao: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.

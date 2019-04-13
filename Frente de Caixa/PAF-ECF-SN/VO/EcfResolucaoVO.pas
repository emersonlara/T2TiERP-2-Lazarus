{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado � tabela [ECF_RESOLUCAO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2014 T2Ti.COM                                          
                                                                                
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
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (t2ti.com@gmail.com)                    
@version 2.0                                                                    
*******************************************************************************}
unit EcfResolucaoVO;

{$mode objfpc}{$H+}

interface

uses
  VO, Classes, SysUtils, FGL, EcfPosicaoComponentesVO;

type
  TEcfResolucaoVO = class(TVO)
  private
    FID: Integer;
    FRESOLUCAO_TELA: String;
    FLARGURA: Integer;
    FALTURA: Integer;
    FIMAGEM_TELA: String;
    FIMAGEM_MENU: String;
    FIMAGEM_SUBMENU: String;
    FHOTTRACK_COLOR: String;
    FITEM_STYLE_FONT_NAME: String;
    FITEM_STYLE_FONT_COLOR: String;
    FITEM_SEL_STYLE_COLOR: String;
    FLABEL_TOTAL_GERAL_FONT_COLOR: String;
    FITEM_STYLE_FONT_STYLE: String;
    FEDITS_COLOR: String;
    FEDITS_FONT_COLOR: String;
    FEDITS_DISABLED_COLOR: String;
    FEDITS_FONT_NAME: String;
    FEDITS_FONT_STYLE: String;

    FListaEcfPosicaoComponentesVO: TListaEcfPosicaoComponentesVO;

  published
    constructor Create; override;
    destructor Destroy; override;

    property Id: Integer  read FID write FID;
    property ResolucaoTela: String  read FRESOLUCAO_TELA write FRESOLUCAO_TELA;
    property Largura: Integer  read FLARGURA write FLARGURA;
    property Altura: Integer  read FALTURA write FALTURA;
    property ImagemTela: String  read FIMAGEM_TELA write FIMAGEM_TELA;
    property ImagemMenu: String  read FIMAGEM_MENU write FIMAGEM_MENU;
    property ImagemSubmenu: String  read FIMAGEM_SUBMENU write FIMAGEM_SUBMENU;
    property HottrackColor: String  read FHOTTRACK_COLOR write FHOTTRACK_COLOR;
    property ItemStyleFontName: String  read FITEM_STYLE_FONT_NAME write FITEM_STYLE_FONT_NAME;
    property ItemStyleFontColor: String  read FITEM_STYLE_FONT_COLOR write FITEM_STYLE_FONT_COLOR;
    property ItemSelStyleColor: String  read FITEM_SEL_STYLE_COLOR write FITEM_SEL_STYLE_COLOR;
    property LabelTotalGeralFontColor: String  read FLABEL_TOTAL_GERAL_FONT_COLOR write FLABEL_TOTAL_GERAL_FONT_COLOR;
    property ItemStyleFontStyle: String  read FITEM_STYLE_FONT_STYLE write FITEM_STYLE_FONT_STYLE;
    property EditsColor: String  read FEDITS_COLOR write FEDITS_COLOR;
    property EditsFontColor: String  read FEDITS_FONT_COLOR write FEDITS_FONT_COLOR;
    property EditsDisabledColor: String  read FEDITS_DISABLED_COLOR write FEDITS_DISABLED_COLOR;
    property EditsFontName: String  read FEDITS_FONT_NAME write FEDITS_FONT_NAME;
    property EditsFontStyle: String  read FEDITS_FONT_STYLE write FEDITS_FONT_STYLE;

    property ListaEcfPosicaoComponentesVO: TListaEcfPosicaoComponentesVO read FListaEcfPosicaoComponentesVO write FListaEcfPosicaoComponentesVO;

  end;

  TListaEcfResolucaoVO = specialize TFPGObjectList<TEcfResolucaoVO>;

implementation

constructor TEcfResolucaoVO.Create;
begin
  inherited;

  FListaEcfPosicaoComponentesVO := TListaEcfPosicaoComponentesVO.Create;
end;

destructor TEcfResolucaoVO.Destroy;
begin
  FreeAndNil(FListaEcfPosicaoComponentesVO);

  inherited;
end;


initialization
  Classes.RegisterClass(TEcfResolucaoVO);

finalization
  Classes.UnRegisterClass(TEcfResolucaoVO);

end.

$PBExportHeader$w_order.srw
forward
global type w_order from w_response_base
end type
type dw_1 from datawindow within w_order
end type
type cb_1 from commandbutton within w_order
end type
type dw_2 from datawindow within w_order
end type
end forward

global type w_order from w_response_base
integer width = 2089
integer height = 2084
string title = "Sales Order Details"
dw_1 dw_1
cb_1 cb_1
dw_2 dw_2
end type
global w_order w_order

on w_order.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_2
end on

on w_order.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.dw_2)
end on

event open;call super::open;String		ls_id
Long		ll_id


ls_id = Message.StringParm

ll_id = Long(ls_id)

dw_1.SetTransObject( sqlca )
dw_1.Retrieve(ll_id)

dw_2.SetTransObject( sqlca )
dw_2.Retrieve(ll_id)
end event

type dw_1 from datawindow within w_order
integer x = 55
integer y = 192
integer width = 1957
integer height = 392
integer taborder = 10
string title = "none"
string dataobject = "d_sales"
boolean border = false
boolean livescroll = true
end type

type cb_1 from commandbutton within w_order
integer x = 1705
integer y = 1800
integer width = 311
integer height = 104
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;CLOSE(Parent)
end event

type dw_2 from datawindow within w_order
integer x = 55
integer y = 608
integer width = 1952
integer height = 1076
integer taborder = 20
string title = "none"
string dataobject = "d_sales_items"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type


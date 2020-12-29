$PBExportHeader$w_select_dataobject.srw
forward
global type w_select_dataobject from w_response_base
end type
type cb_2 from commandbutton within w_select_dataobject
end type
type cb_1 from commandbutton within w_select_dataobject
end type
type dw_2 from datawindow within w_select_dataobject
end type
type st_3 from statictext within w_select_dataobject
end type
type dw_1 from datawindow within w_select_dataobject
end type
type st_2 from statictext within w_select_dataobject
end type
type ddlb_1 from dropdownlistbox within w_select_dataobject
end type
type st_1 from statictext within w_select_dataobject
end type
end forward

global type w_select_dataobject from w_response_base
integer width = 2592
integer height = 2076
string title = "Select DataObject"
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
st_3 st_3
dw_1 dw_1
st_2 st_2
ddlb_1 ddlb_1
st_1 st_1
end type
global w_select_dataobject w_select_dataobject

type variables
String is_pbl[]

end variables

forward prototypes
public function any f_conver_char2list (string as_input, string as_str)
end prototypes

public function any f_conver_char2list (string as_input, string as_str);/*Process the path contained in the ls_list string, and split the string*/
String str_list[]
String str_temp
Integer i =1
Long	  ll_pos

//as_input: input string, as_str: separator
ll_pos = pos(as_input, as_str, 1) //The position of the separator

DO
	IF ll_pos = 0 THEN
		str_list[i] = as_input
	ELSE
		str_list[i] = left(as_input, ll_pos - 1)  //str_list is the first half of the string
		i++
		as_input = mid(as_input, ll_pos + 1)  //Then extract the following string to continue to judge
		ll_pos = pos(as_input, as_str, 1)
		IF ll_pos = 0 THEN str_list[i] = as_input
	END IF
LOOP WHILE ll_pos <> 0
RETURN str_list

	
end function

on w_select_dataobject.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.st_3=create st_3
this.dw_1=create dw_1
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.ddlb_1
this.Control[iCurrent+8]=this.st_1
end on

on w_select_dataobject.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.st_3)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.st_1)
end on

event open;call super::open;/*Update the datawindow under Libraries and libraries*/
String	  ls_list, ls_datawindow
Long ll_loop, ll_last
ll_last = 1


//Target
ddlb_1.AddItem( GetCurrentDirectory())
ddlb_1.SelectItem(1)

//Libraries: get the pbl path under the current workspace
ls_list = getlibrarylist()

is_pbl= f_conver_char2list(ls_list, ",")
 
FOR ll_loop=1 TO upperbound(is_pbl)
	dw_1.InsertRow(0)    
	dw_1.SetItem(ll_loop, 1, is_pbl[ll_loop])
NEXT

end event

type cb_2 from commandbutton within w_select_dataobject
integer x = 2094
integer y = 1744
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;
Close(Parent)
end event

type cb_1 from commandbutton within w_select_dataobject
integer x = 1650
integer y = 1744
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
boolean default = true
end type

event clicked;String ls_Object

ls_Object = dw_2.GetItemString(dw_2.GetRow(), 1)

IF isNull(ls_Object) OR ls_Object = "" THEN
	Messagebox("Tip","You haven't selected a DataObject!")
END IF

CloseWithReturn(Parent, ls_Object)
end event

type dw_2 from datawindow within w_select_dataobject
event ue_click_ok ( )
integer x = 1307
integer y = 312
integer width = 1193
integer height = 1292
integer taborder = 20
string title = "none"
string dataobject = "d_dataobject"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;SetRow(row)


end event

event doubleclicked;
cb_1.Event Clicked()
end event

type st_3 from statictext within w_select_dataobject
integer x = 1307
integer y = 212
integer width = 448
integer height = 92
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "DataWindow:"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_select_dataobject
integer x = 78
integer y = 312
integer width = 1193
integer height = 1292
integer taborder = 20
string title = "none"
string dataobject = "d_library"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;Long ll_loop
String ls_datawindow

dw_2.SetRedraw( False )
dw_2.reset()
ls_datawindow = LibraryDirectoryEx(is_pbl[currentrow], DirDataWindow!)
dw_2.importstring( ls_datawindow)
dw_2.Filter()
dw_2.SetSort("#1")
dw_2.Sort()
dw_2.SetRedraw( True )

end event

event clicked;SetRow(row)
end event

type st_2 from statictext within w_select_dataobject
integer x = 78
integer y = 204
integer width = 302
integer height = 92
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Libraries:"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_select_dataobject
integer x = 311
integer y = 52
integer width = 2190
integer height = 240
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean allowedit = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_select_dataobject
integer x = 78
integer y = 60
integer width = 224
integer height = 92
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Target:"
boolean focusrectangle = false
end type


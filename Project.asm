.model small
.stack 100h
.data

id db 6 dup(?)
Criminal_name db 20 dup('<')
Crime db 11 dup('=')
fir_status db 11 dup('>')
SearchById db 5 dup('?')
bp_Address dw ? 
fir_not_issued db 'Not Issued>$'
fir_issued db     'Issued>>>>>$'
ret_Address dw ?

newLine db 10,13,'$'

msg_Criminal_ID db 10,13,'                 Criminal ID: $'
msg_FIR db         10,13,'                 FIR Status: $'
msg_Crime db       10,13,'                 Crime: $'
msg_Name db        10,13,'                 Criminal Name: $'


Enter_Crime db       10,13,'                 Enter Crime: $'
Enter_Name db        10,13,'                 Enter Criminal Name: $'
Enter_Criminal_ID db 10,13,'                 Enter Criminal ID: $'

Not_Found_Criminal db         10,13,'                 Criminal Not Found$'


Crime_Updated db       10,13, '                 Crime Updated Successfully $'
Record_Deleted db       10,13,'                 Record Deleted Successfully $'


FIR_Issued_Successfully db       10,13,'                 FIR Issued Successfully $'


Start DB 10,13,10,13,'                 Welcome to Police FIR Management System$',10,13 
Enter_choice DB 10,13,10,13,'Enter your Choice: $'

Menu_Criminal DB 10,13,'  *                 1.Criminal Record         *$' 
Menu_FIR      DB 10,13,'  *                 2.Fir                     *$'
Menu_exit     DB 10,13,'  *                 3.exit                    *$'
 
               
               
M8 DB 10,13,10,13,'*Choise Option*$'
  
 
Menu_Criminal_Add   DB 10,13, '  *         1.Add Criminal Record                          *$' 
Menu_Criminal_Show   DB 10,13,'  *         2.Show Criminal Record                         *$'
Menu_Criminal_Update DB 10,13,'  *         3.Update Crime of Criminal                      *$'
Menu_Criminal_delete DB 10,13,'  *         4.Delete Criminal Record                       *$'
Menu_Criminal_back DB 10,13,  '  *         5.Back                                         *$'






.code





    
  
    
    getInfo proc
       mov ax,@data
       mov ds,ax

       pop ax
       mov [ret_Address],ax
       
       
       
       
       mov cx,1
       
       label:
            
            mov si,offset Criminal_name
            mov bl,0
            mov bh,0
            mov dl,0
            mov dh,0
            
            lea dx,Enter_Name
            mov ah,9
            int 21h
            
            input:
            
            mov ah,1
            int 21h
            
            cmp al,13
            je br_name
            
            mov [si],al
            inc si
            inc bl
            jmp input
            
            Cin:
            mov si,offset Crime
            
            lea dx,newLine
            mov ah,9
            int 21h
            
            lea dx,Enter_Crime
            mov ah,9
            int 21h
            
            
            input_crime:
            
            mov ah,1
            int 21h
            
            cmp al,13
            je br_crime
            
            mov [si],al
            inc si
            inc dh
            jmp input_crime
            
            
            
            Cin2:
            
            lea dx,newLine
            mov ah,9
            int 21h
            
            mov si,offset fir_not_issued
            add si,10           
            mov dl,0
            
            input_fir_status:
            push [si]
            dec si
            inc dl
            
            cmp dl,11
            jne input_fir_status
            
            mov si,offset id
            lea dx,Enter_Criminal_ID
            mov ah,9
            int 21h
            
            input_Id:
            
            mov ah,1
            int 21h
            
            cmp al,13
            je br_id
            
            mov [si],al
            inc si
            inc bh
            jmp input_Id
            
            endl:
            mov dl,10
            mov ah,2
            int 21h
            
            push 150
            
       loop label
       
       jmp end_getInfo
       
       
       
       br_name:
       cmp bl,20
       je name_push
       
       mov [si],'<'
       inc bl
       inc si
       jmp br_name
       
       br_crime:
       
       cmp dh,11
       je crime_push
       
       mov [si],'='
       inc dh
       inc si
       jmp br_crime
       
       br_id:     
       cmp bh,6
       je id_push
       
       mov [si],'?'
       inc bh
       inc si
       jmp br_id
       
       name_push:
       dec si
       push [si]
       dec bl
       cmp bl,0
       jne name_push
       jmp Cin
       
       crime_push:
       dec si
       push [si]
       dec dh
       cmp dh,0
       jne crime_push
       jmp Cin2
       
       id_push:
       dec si
       push [si]
       dec bh
       cmp bh,0
       jne id_push
       jmp endl 
       
       print_l:
    
       lea dx,newLine
       mov ah,9
       int 21h
       
       add bp,2
       jmp print
       
       end_getInfo:
      
       jmp [ret_Address] 
       ret
       
    getInfo endp 
    
    PrintInfo proc
       
       mov ax,@data
       mov ds,ax 
        
       pop ax
       mov [ret_Address],ax
     
       lea dx,msg_Criminal_ID
       mov ah,9
       int 21h
        
       print:
       mov dl,[bp]
       
       cmp dl,'?'
       je end_print
       
       cmp dl,'>'
       je end_print
       
       cmp dl,'<'
       je end_print
       
       cmp dl,'='
       je end_print
       
       cmp dl,239
       je end_print
       
       cmp dl,150
       je endprintinfo
       
       cmp dl,255
       je endprintinfo
       
       
       jmp Display 
       
       end_print:
       add bp,2
       jmp print
       
       Display:
       mov ah,2
       int 21h
       
       add bp,2
       
       mov dl,[bp]
       
       cmp dl,'?'
       je disp_Fir_msg
       
       cmp dl,'>'
       je disp_Crime_msg
       
       cmp dl,'='
       je disp_Name_msg
       
       sub bp,2
       jmp end_print  
       
       disp_Fir_msg:
      
       
       lea dx, msg_FIR
       mov ah,9
       int 21h
       
       sub bp,2
       
       jmp end_print
       
       disp_Crime_msg:
      
       
       lea dx, msg_Crime
       mov ah,9
       int 21h
       
       sub bp,2
       
       jmp end_print
       
       disp_Name_msg:
      
       
       lea dx, msg_Name
       mov ah,9
       int 21h
       
       sub bp,2
       
       jmp end_print
       
       endprintinfo:
       
       lea dx,newLine
       mov ah,9
       int 21h
            
       lea dx,newLine
       mov ah,9
       int 21h
       
       jmp [ret_Address]
       ret
       
       PrintInfo endp
    
    
    Search proc
        
        
        mov ax,@data
        mov ds,ax
        
        pop ax
        mov [ret_Address],ax
        
        lea dx,Enter_Criminal_ID
        mov ah,9
        int 21h
        
        
        
        mov cx,5
        mov bx,0
        mov si,offset SearchById
         
        search_id:
        
        mov ah,1
        int 21h
        
        mov [si],al
        inc si
        
        loop search_id
        
        mov bp,sp               
        
        mov si,offset SearchById
        
        check:
        mov al,[bp]
        
        cmp al,57
        jle compare
        
        check_mid:
        
        add bp,2
        
        cmp [bp],150
        je new_obj
        
        cmp [bp],255
        je not_found
        
        jmp check
        
        compare:
        
        cmp [si],al
        je incr
        
        cmp [si],al
        jne check_mid
        
        jmp compare
        
        incr:
        inc si
        inc bl
        add bp,2
        mov al,[bp]
        
        cmp bl,5
        je found
        
        jmp check
        
        new_obj:
        add bp,2
        mov si, offset SearchById
        mov bl,0
        jmp check
        
        not_found:
        
        lea dx,newLine
        mov ah,9
        int 21h
            
        lea dx,newLine
        mov ah,9
        int 21h
        
        lea dx,Not_Found_Criminal
        mov ah,9
        int 21h
        
        lea dx,newLine
        mov ah,9
        int 21h
            
        lea dx,newLine
        mov ah,9
        int 21h
        
        
        jmp Program_Start
        
        found: 
        
        lea dx,newLine
        mov ah,9
        int 21h
            
        lea dx,newLine
        mov ah,9
        int 21h
        
        mov dl,5
        sub bp,10
      
        mov bp_Address,bp
        jmp [ret_Address]
        ret
    Search endp


    Update_Crime proc
        
        
        mov ax,@data
        mov ds,ax
        
        pop ax
        mov [ret_Address],ax
        
        lea dx,Enter_Crime
        mov ah,9
        int 21h
        
        mov dh,0
        add bp,54
        mov si,offset Crime
        
        Update_input_crime:
            
            mov ah,1
            int 21h
            
            cmp al,13
            je br_update_crime
            
            mov [si],al
            inc si
            inc dh
            jmp Update_input_crime
        
            br_update_crime:
       
            cmp dh,11
            je crime_Update_push
           
            mov [si],'='
            inc dh
            inc si
            jmp br_update_crime
            
            crime_Update_push:
            
                mov cx,11
                
                label_push_crime:
                dec si
                mov al,[si]
                mov [bp],al
              
                sub bp,2
                
                loop label_push_crime
                mov bp,bp_Address
              
                
                lea dx,newLine
                mov ah,9
                int 21h
                    
                lea dx,newLine
                mov ah,9
                int 21h
                
                jmp [ret_Address] 
            
        ret 
    Update_Crime endp
    
    
    
    Issue_FIR proc
        mov ax,@data
        mov ds,ax
        
        pop ax
        mov [ret_Address],ax
        
        add bp,32
        
        mov cx,11
        mov si,offset fir_issued
        add si,10
        
        FIR_Issuing:
            mov al,[si]
            mov [bp],al
            dec si
            sub bp,2
            
        loop FIR_Issuing
        
        jmp [ret_Address]
        ret
    Issue_FIR endp
    
    Delete_Criminal proc
        mov ax,@data
        mov ds,ax
        
        pop ax
        mov [ret_Address],ax
        
        Del_Record:
        cmp [bp],150
        je end_Delete
        
        cmp [bp],255
        je end_Delete
        
        mov [bp],239
        add bp,2
        
        jmp Del_Record
        
        end_Delete:
        
        jmp [ret_Address]
        ret
    Delete_Criminal endp





main proc
       push 255
       
       mov ax,@data
       mov ds,ax
       
       Program_Start:
       
       lea dx,Start
       mov ah,9
       int 21h
       
       lea dx,Menu_Criminal
       mov ah,9
       int 21h
       
       lea dx,Menu_FIR
       mov ah,9
       int 21h
       
       lea dx,Menu_exit
       mov ah,9
       int 21h
       
       lea dx,Enter_choice
       mov ah,9
       int 21h
       
       mov ah,1
       int 21h
       
       mov bl,al
       
       lea dx,newLine
       mov ah,9
       int 21h
       
       lea dx,newLine
       mov ah,9
       int 21h
       
       mov al,bl
       
       cmp al,'1'
       je Criminals_Menu
       
       cmp al,'2'
       je FIR_Menu
       
       cmp al,'3'
       je endpr
       
            Criminals_Menu:
            
            lea dx,Menu_Criminal_Add
            mov ah,9
            int 21h
            
            lea dx,Menu_Criminal_Show
            mov ah,9
            int 21h
            
            lea dx,Menu_Criminal_Update
            mov ah,9
            int 21h
            
            lea dx,Menu_Criminal_delete
            mov ah,9
            int 21h
            
            lea dx,Menu_Criminal_back
            mov ah,9
            int 21h
            
            lea dx,Enter_choice
            mov ah,9
            int 21h
            
            mov ah,1
            int 21h
            
            mov bl,al
       
            lea dx,newLine
            mov ah,9
            int 21h
           
            lea dx,newLine
            mov ah,9
            int 21h
           
            mov al,bl
           
            cmp al,'1'
            je Criminals_Add
           
            cmp al,'2'
            je Criminals_Show
           
            cmp al,'3'
            je Criminals_Update
            
            cmp al,'4'
            je Criminals_Delete
            
            cmp al,'5'
            je Criminals_Back
            
                    Criminals_Add:    
                    call getInfo
                    
                    jmp Criminals_Menu
                    
                    Criminals_Show:
                    call Search
                    call PrintInfo
                    
                    jmp Criminals_Menu
                    
                    Criminals_Update:
                    call Search
                    call Update_Crime
                    
                    lea dx,Crime_Updated
                    mov ah,9
                    int 21h
                    
                    lea dx,newLine
                    mov ah,9
                    int 21h
                    
                    lea dx,newLine
                    mov ah,9
                    int 21h
                    
                    jmp Criminals_Menu
                    
                    Criminals_Delete:
                    call Search
                    call Delete_Criminal
                    
                    lea dx,Record_Deleted
                    mov ah,9
                    int 21h
                    
                    lea dx,newLine
                    mov ah,9
                    int 21h
                    
                    lea dx,newLine
                    mov ah,9
                    int 21h
                    
                    jmp Criminals_Menu
                    
                    Criminals_Back:
                    jmp Program_Start
            
            
            
            
            
            
            
            
            
            
            jmp Criminals_Menu
            
            
            
            FIR_Menu:
            
            call Search
            call Issue_FIR
            
            lea dx,FIR_Issued_Successfully
            mov ah,9
            int 21h
            
            lea dx,newLine
            mov ah,9
            int 21h
           
            lea dx,newLine
            mov ah,9
            int 21h
            
            jmp Program_Start
       
       endpr:
       mov ah,4ch
       int 21h
    main endp 
    
    
        
        
        
    
        
    
    
    
end main           

























































































;
;.model small
;.stack 100h
;.data
;
;id db 6 dup(?)
;arr db 10 dup('$'),0
;.code
;main proc
;       mov ax,@data
;       mov ds,ax
;       
;       push 255
;       
;       mov cx,2
;       
;       
;       
;       label:
;            
;            mov si,offset arr
;            mov bl,0
;            mov bh,0
;            
;            input:
;            
;            mov ah,1
;            int 21h
;            
;            cmp al,13
;            je br_name
;            
;            mov [si],al
;            inc si
;            inc bl
;            jmp input
;            
;            Cin:
;            mov si,offset id
;            
;            mov dl,10
;            mov ah,2
;            int 21h
;            
;            input_Id:
;            
;            mov ah,1
;            int 21h
;            
;            cmp al,13
;            je br_id
;            
;            mov [si],al
;            inc si
;            inc bh
;            jmp input_Id
;            
;            endl:
;            mov dl,10
;            mov ah,2
;            int 21h
;            
;            push 150
;            
;       loop label
;       
;       print:
;       pop dx
;       
;       cmp dl,'?'
;       je print
;       
;       cmp dl,'$'
;       je print
;       
;       cmp dl,150
;       je print_l
;       
;       cmp dl,255
;       je endpr
;       
;       mov ah,2
;       int 21h
;       jmp print
;       
;       br_name:
;       cmp bl,20
;       je name_push
;       
;       mov [si],'$'
;       inc bl
;       inc si
;       jmp br_name
;       
;       br_id:     
;       cmp bh,6
;       je id_push
;       
;       mov [si],'?'
;       inc bh
;       inc si
;       jmp br_id
;       
;       name_push:
;       dec si
;       push [si]
;       dec bl
;       cmp bl,0
;       jne name_push
;       jmp Cin
;       
;       id_push:
;       dec si
;       push [si]
;       dec bh
;       cmp bh,0
;       jne id_push
;       jmp endl 
;       
;       print_l:
;       mov dl,10
;       mov ah,2
;       int 21h
;       
;       mov dl,13
;       mov ah,2
;       int 21h
;       jmp print
;       
;       endpr:
;    
;    main endp
;end main          



























































       ;
;
;.model small
;.stack 100h
;.data
;
;id db 6 dup(?)
;Criminal_name db 20 dup('<')
;Crime db 11 dup('=')
;fir_status db 11 dup('>')
;.code
;main proc
;    push 255
;    call getInfo
;     
;       ;mov ax,@data
;;       mov ds,ax
;;       
;;       push 255
;;       
;;       mov cx,1
;;       
;;       ;not issued
;;       
;;       label:
;;            
;;            mov si,offset arr_name
;;            mov bl,0
;;            mov bh,0
;;            
;;            input:
;;            
;;            mov ah,1
;;            int 21h
;;            
;;            cmp al,13
;;            je br_name
;;            
;;            mov [si],al
;;            inc si
;;            inc bl
;;            jmp input
;;            
;;            Cin:
;;            mov si,offset id
;;            
;;            mov dl,10
;;            mov ah,2
;;            int 21h
;;            
;;            input_Id:
;;            
;;            mov ah,1
;;            int 21h
;;            
;;            cmp al,13
;;            je br_id
;;            
;;            mov [si],al
;;            inc si
;;            inc bh
;;            jmp input_Id
;;            
;;            endl:
;;            mov dl,10
;;            mov ah,2
;;            int 21h
;;            
;;            push 150
;;            
;;       loop label
;;       
;;       
;;       
;;       
;;       print:
;;       pop dx
;;       
;;       cmp dl,'?'
;;       je print
;;       
;;       cmp dl,'$'
;;       je print
;;       
;;       cmp dl,150
;;       je print_l
;;       
;;       cmp dl,255
;;       je endpr
;;       
;;       mov ah,2
;;       int 21h
;;       jmp print
;;       
;;       br_name:
;;       cmp bl,20
;;       je name_push
;;       
;;       mov [si],'<'
;;       inc bl
;;       inc si
;;       jmp br_name
;;       
;;       br_id:     
;;       cmp bh,6
;;       je id_push
;;       
;;       mov [si],'?'
;;       inc bh
;;       inc si
;;       jmp br_id
;;       
;;       name_push:
;;       dec si
;;       push [si]
;;       dec bl
;;       cmp bl,0
;;       jne name_push
;;       jmp Cin
;;       
;;       id_push:
;;       dec si
;;       push [si]
;;       dec bh
;;       cmp bh,0
;;       jne id_push
;;       jmp endl 
;;       
;;       print_l:
;;       call newLine
;;       jmp print
;       
;       endpr:
;       mov ah,4ch
;       int 21h
;    main endp 
;    
;    
;    
;    newLine proc
;        
;        mov dx,10
;        mov ah,2
;        int 21h
;        
;        mov dx,13
;        mov ah,2
;        int 21h
;        ret
;        
;    newLine endp
;    
;    getInfo proc
;       pop dx 
;       mov ax,@data
;       mov ds,ax
;       
;       
;       
;       mov cx,1
;       
;       ;not issued
;       
;       label:
;            
;            mov si,offset Criminal_name
;            mov bl,0
;            mov bh,0
;            mov dl,0
;            mov dh,0
;            
;            input:
;            
;            mov ah,1
;            int 21h
;            
;            cmp al,13
;            je br_name
;            
;            mov [si],al
;            inc si
;            inc bl
;            jmp input
;            
;            Cin:
;            mov si,offset id
;            
;            mov dl,10
;            mov ah,2
;            int 21h
;            
;            input_Id:
;            
;            mov ah,1
;            int 21h
;            
;            cmp al,13
;            je br_id
;            
;            mov [si],al
;            inc si
;            inc bh
;            jmp input_Id
;            
;            endl:
;            mov dl,10
;            mov ah,2
;            int 21h
;            
;            push 150
;            
;       loop label
;       
;       
;       
;       
;       print:
;       pop dx
;       
;       cmp dl,'?'
;       je print
;       
;       cmp dl,'<'
;       je print
;       
;       cmp dl,150
;       je print_l
;       
;       cmp dl,255
;       je endpr
;       
;       mov ah,2
;       int 21h
;       jmp print
;       
;       br_name:
;       cmp bl,20
;       je name_push
;       
;       mov [si],'<'
;       inc bl
;       inc si
;       jmp br_name
;       
;       br_id:     
;       cmp bh,6
;       je id_push
;       
;       mov [si],'?'
;       inc bh
;       inc si
;       jmp br_id
;       
;       name_push:
;       dec si
;       push [si]
;       dec bl
;       cmp bl,0
;       jne name_push
;       jmp Cin
;       
;       id_push:
;       dec si
;       push [si]
;       dec bh
;       cmp bh,0
;       jne id_push
;       jmp endl 
;       
;       print_l:
;       call newLine
;       jmp print
;        
;       ret
;       
;    getInfo endp
;        
;        
;    
;        
;    
;    
;    
;end main 
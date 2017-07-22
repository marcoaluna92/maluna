%Algoritmo busqueda en anchura
clear all;
clc
disp('Ingresar estado inicial de la forma [Mo, Co, Me, Ce, C]');
disp('Mo: Número de monjes en el margen oeste');
disp('Co: Número de canibales en el margen oeste');
disp('Me: Número de monjes en el margen este');
disp('Ce: Número de canibales en el margen este');
disp('C: E=1, O=0 donde esta la canoa');
EsInicial=input('Estado inicial = ');
EsFinal=input('Estado final = ');

Moi=EsInicial(1);
Coi=EsInicial(2);
Mei=EsInicial(3);
Cei=EsInicial(4);
Ci=EsInicial(5);

Mof=EsFinal(1);
Cof=EsFinal(2);
Mef=EsFinal(3);
Cef=EsFinal(4);
Cf=EsFinal(5);

%Se comienza imprimiendo en la matriz de estados el estado inicial
E=[;]; %Matriz de estados
R=[;]; %Matriz respuesta aux 
M=[;]; %Matriz guardar posiciones

E(1,1)=Moi;
E(1,2)=Coi;
E(1,3)=Mei;
E(1,4)=Cei;
E(1,5)=Ci;

   tic
    for n=0:1:inf
%     Para cada valor se evalua todas las condiciones y se guarda los
%     estados uno debajo de otro tambien se guarda el estado anterior.
%     Una vez que encuentra el estado final aplica break y sale del for

if E(n+1,5)==0 
%     condicion 1 Viajan un monje y un caníbal de O a E:
%     Mo>=1 AND Co>=1 AND Ce+1<=Me+1 =>
%     (Mo-1, Co-1, Me+1, Ce+1, E)
    if  E(n+1,1)>=1 && E(n+1,2)>=1 && (E(n+1,4)+1<=E(n+1,3)+1)
    E(5*n+6,1)=E(n+1,1)-1; %Mo
    E(5*n+6,2)=E(n+1,2)-1; %Co
    E(5*n+6,3)=E(n+1,3)+1; %Me
    E(5*n+6,4)=E(n+1,4)+1; %Ce
    E(5*n+6,5)=1; %C
    E(5*n+6,6)=E(n+1,1); %Mo anterior
    E(5*n+6,7)=E(n+1,2); %Co anterior
    E(5*n+6,8)=E(n+1,3); %Me anterior
    E(5*n+6,9)=E(n+1,4); %Ce anterior
    E(5*n+6,10)=E(n+1,5); %C anterior
          
    if E(5*n+6,1)==Mof && E(5*n+6,2)==Cof && E(5*n+6,3)==Mef && E(5*n+6,4)==Cef && E(5*n+6,5)==Cf
    fprintf('listo');
    break;
    end
   end
   
%     condicion 2 Viajan dos monjes de O a E:
%    Mo>=2 AND (Mo-2=0 OR Co<=Mo-2) AND Ce<=Me+2=> 
%     (Mo-2, Co, Me+2, Ce, E)
    if (E(n+1,1)>=2)&&((E(n+1,1)-2==0)||(E(n+1,2)<=E(n+1,1)-2)) && (E(n+1,4)<=E(n+1,3)+2)
    E(5*n+3,1)=E(n+1,1)-2; %Mo
    E(5*n+3,2)=E(n+1,2); %Co
    E(5*n+3,3)=E(n+1,3)+2; %Me
    E(5*n+3,4)=E(n+1,4); %Ce
    E(5*n+3,5)=1; %C
    E(5*n+3,6)=E(n+1,1); %Mo anterior
    E(5*n+3,7)=E(n+1,2); %Co anterior
    E(5*n+3,8)=E(n+1,3); %Me anterior
    E(5*n+3,9)=E(n+1,4); %Ce anterior
    E(5*n+3,10)=E(n+1,5); %C anterior
   
      
    if E(5*n+3,1)==Mof && E(5*n+3,2)==Cof &&  E(5*n+3,3)==Mef && E(5*n+3,4)==Cef && E(5*n+3,5)==Cf
    fprintf('listo');
    break;
    end
    end
    
    
% condicion 3 Viajan dos caníbales de O a E:
%    Co>=2 AND (Me=0 OR Ce+2<=Me) => 
%    (Mo, Co-2, Me, Ce+2, E)
    if E(n+1,2)>=2 && ((E(n+1,3)==0) || (E(n+1,4)+2<=E(n+1,3))) 
    E(5*n+4,1)=E(n+1,1); %Mo
    E(5*n+4,2)=E(n+1,2)-2; %Co
    E(5*n+4,3)=E(n+1,3); %Me
    E(5*n+4,4)=E(n+1,4)+2; %Ce
    E(5*n+4,5)=1; %C
    E(5*n+4,6)=E(n+1,1); %Mo anterior
    E(5*n+4,7)=E(n+1,2); %Co anterior
    E(5*n+4,8)=E(n+1,3); %Me anterior
    E(5*n+4,9)=E(n+1,4); %Ce anterior
    E(5*n+4,10)=E(n+1,5); %C anterior
   
      
    if E(5*n+4,1)==Mof && E(5*n+4,2)==Cof &&  E(5*n+4,3)==Mef && E(5*n+4,4)==Cef && E(5*n+4,5)==Cf 
    fprintf('listo');
    break;
    end
    end
    
  %     condicion 4 Viaja un monje de O a E:
%  Mo>=1 AND (Mo-1=0 OR Co<=Mo-1) AND Ce<= Me+1 => 
%    (Mo-1 Co Me+1 Ce E)
    if E(n+1,1)>=1 && ((E(n+1,1)-1==0)||(E(n+1,2)<=(E(n+1,1)-1))) && E(n+1,4)<=E(n+1,3)+1 
    E(5*n+5,1)=E(n+1,1)-1; %Mo
    E(5*n+5,2)=E(n+1,2); %Co
    E(5*n+5,3)=E(n+1,3)+1; %Me
    E(5*n+5,4)=E(n+1,4); %Ce
    E(5*n+5,5)=1; %C
    
    E(5*n+5,6)=E(n+1,1); %Mo anterior
    E(5*n+5,7)=E(n+1,2); %Co anterior
    E(5*n+5,8)=E(n+1,3); %Me anterior
    E(5*n+5,9)=E(n+1,4); %Ce anterior
    E(5*n+5,10)=E(n+1,5); %C anterior
    
      
    if E(5*n+5,1)==Mof && E(5*n+5,2)==Cof &&  E(5*n+5,3)==Mef && E(5*n+5,4)==Cef && E(5*n+5,5)==Cf
    fprintf('listo');
    break;
    end
    end  
    
%   condicion 5 Viaja un caníbal de O a E:
% Co>=1 AND (Me=0 OR Ce+1<=Me) => 
%   (Mo, Co-1, Me, Ce+1, E)
    if E(n+1,2)>=1 && ((E(n+1,3)==0)||(E(n+1,4)+1<=(E(n+1,3)))) %&& E(n+1,1)<4 && E(n+1,2)<4 && E(n+1,3)<4 && E(n+1,4)<4)
    E(5*n+2,1)=E(n+1,1); %Mo
    E(5*n+2,2)=E(n+1,2)-1; %Co
    E(5*n+2,3)=E(n+1,3); %Me
    E(5*n+2,4)=E(n+1,4)+1; %Ce
    E(5*n+2,5)=1; %C
    
    E(5*n+2,6)=E(n+1,1); %Mo anterior
    E(5*n+2,7)=E(n+1,2); %Co anterior
    E(5*n+2,8)=E(n+1,3); %Me anterior
    E(5*n+2,9)=E(n+1,4); %Ce anterior
    E(5*n+2,10)=E(n+1,5); %C anterior
    
      
    if E(5*n+2,1)==Mof && E(5*n+2,2)==Cof &&  E(5*n+2,3)==Mef && E(5*n+2,4)==Cef && E(5*n+2,5)==Cf
    fprintf('listo');
    break;
    end
    end
    

    
else 
        
%     condicion 1 Viajan un monje y un caníbal de E a O:
%    Me>=1 AND Ce>=1 AND Co+1<=Mo+1 => 
%     (Mo+1, Co+1, Me-1, Ce-1,O)
    if E(n+1,3)>=1 && E(n+1,4)>=1 && E(n+1,2)+1<=E(n+1,1)+1
    E(5*n+6,1)=E(n+1,1)+1; %Mo
    E(5*n+6,2)=E(n+1,2)+1; %Co
    E(5*n+6,3)=E(n+1,3)-1; %Me
    E(5*n+6,4)=E(n+1,4)-1; %Ce
    E(5*n+6,5)=0; %C
    E(5*n+6,6)=E(n+1,1); %Mo anterior
    E(5*n+6,7)=E(n+1,2); %Co anterior
    E(5*n+6,8)=E(n+1,3); %Me anterior
    E(5*n+6,9)=E(n+1,4); %Ce anterior
    E(5*n+6,10)=E(n+1,5); %C anterior
      
    if E(5*n+6,1)==Mof && E(5*n+6,2)==Cof &&  E(5*n+6,3)==Mef && E(5*n+6,4)==Cef && E(5*n+6,5)==Cf 
    fprintf('listo');
    break;
    end
    end
    
%      condicion 2 Viajan dos monjes de E a O:
%    Me>=2 AND (Me-2=0 OR Ce<=Me-2) AND Co<=Mo+2 => 
%    (Mo+2, Co, Me-2, Ce, O)
    if E(n+1,3)>=2 && ((E(n+1,4)-2==0)||(E(n+1,4)<=E(n+1,3)-2)) && E(n+1,2)<=E(n+1,1)+2 
    E(5*n+3,1)=E(n+1,1)+2; %Mo
    E(5*n+3,2)=E(n+1,2); %Co
    E(5*n+3,3)=E(n+1,3)-2; %Me
    E(5*n+3,4)=E(n+1,4); %Ce
    E(5*n+3,5)=0; %C
    E(5*n+3,6)=E(n+1,1); %Mo anterior
    E(5*n+3,7)=E(n+1,2); %Co anterior
    E(5*n+3,8)=E(n+1,3); %Me anterior
    E(5*n+3,9)=E(n+1,4); %Ce anterior
    E(5*n+3,10)=E(n+1,5); %C anterior
      
    if E(5*n+3,1)==Mof && E(5*n+3,2)==Cof && E(5*n+3,3)==Mef && E(5*n+3,4)==Cef && E(5*n+3,5)==Cf
    fprintf('listo');
    break;
    end
    end
    
       
%   condicion 3 Viajan dos caníbales de E a O:
%  Ce>=2 AND (Mo=0 OR Co+2<=Mo) => 
%    (Mo, Co+2, Me, Ce-2, O)
    if E(n+1,4)>=2 && ((E(n+1,1)==0)||(E(n+1,2)+2<=(E(n+1,1))))
    E(5*n+4,1)=E(n+1,1); %Mo
    E(5*n+4,2)=E(n+1,2)+2; %Co
    E(5*n+4,3)=E(n+1,3); %Me
    E(5*n+4,4)=E(n+1,4)-2; %Ce
    E(5*n+4,5)=0; %C
    
    E(5*n+4,6)=E(n+1,1); %Mo anterior
    E(5*n+4,7)=E(n+1,2); %Co anterior
    E(5*n+4,8)=E(n+1,3); %Me anterior
    E(5*n+4,9)=E(n+1,4); %Ce anterior
    E(5*n+4,10)=E(n+1,5); %C anterior
    
        
    if E(5*n+4,1)==Mof && E(5*n+4,2)==Cof &&  E(5*n+4,3)==Mef && E(5*n+4,4)==Cef && E(5*n+4,5)==Cf
    fprintf('listo');
    break;
    end
    
    end
    
    
 %     condicion 4 Viaja un monje de E a O:
% Me>=1 AND (Me-1=0 OR Ce<=Me-1) AND Co<=Mo+1 => 
%   (Mo+1, Co, Me-1, Ce,O)
    if E(n+1,3)>=1 && ((E(n+1,3)-1==0)||E(n+1,4)<=(E(n+1,3)-1)) && E(n+1,2)<=E(n+1,1)+1 
    E(5*n+5,1)=E(n+1,1)+1; %Mo
    E(5*n+5,2)=E(n+1,2); %Co
    E(5*n+5,3)=E(n+1,3)-1; %Me
    E(5*n+5,4)=E(n+1,4); %Ce
    E(5*n+5,5)=0; %C
    
    E(5*n+5,6)=E(n+1,1); %Mo anterior
    E(5*n+5,7)=E(n+1,2); %Co anterior
    E(5*n+5,8)=E(n+1,3); %Me anterior
    E(5*n+5,9)=E(n+1,4); %Ce anterior
    E(5*n+5,10)=E(n+1,5); %C anterior
      
    if E(5*n+5,1)==Mof && E(5*n+5,2)==Cof &&  E(5*n+5,3)==Mef && E(5*n+5,4)==Cef && E(5*n+5,5)==Cf
    fprintf('listo');
    break;
    end
    end
    

%   condicion 5 Viaja un caníbal de E a O:
% Ce>=1 AND (Mo=0 OR Co+1<=Mo) => 
%   (Mo, Co+1, Me, Ce-1, E)
    if E(n+1,4)>=1 && ((E(n+1,1)==0)||(E(n+1,2)+1<=E(n+1,1))) 
    E(5*n+6,1)=E(n+1,1); %Mo
    E(5*n+6,2)=E(n+1,2)+1; %Co
    E(5*n+6,3)=E(n+1,3); %Me
    E(5*n+6,4)=E(n+1,4)-1; %Ce
    E(5*n+6,5)=0; %C
    E(5*n+6,6)=E(n+1,1); %Mo anterior
    E(5*n+6,7)=E(n+1,2); %Co anterior
    E(5*n+6,8)=E(n+1,3); %Me anterior
    E(5*n+6,9)=E(n+1,4); %Ce anterior
    E(5*n+6,10)=E(n+1,5); %C anterior
      
    if E(5*n+6,1)==Mof && E(5*n+6,2)==Cof &&  E(5*n+6,3)==Mef && E(5*n+6,4)==Cef && E(5*n+6,5)==Cf
    fprintf('listo');
    break;
    end
    end
  
end
    
[fil,colum]=find(E(:,1)==0 & E(:,2)==0 & E(:,3)==0 & E(:,4)==0 & E(:,5)==0); %Borrar estados inutiles
E(fil,:)=[];

    end
    
%Para guardar en la matriz, se comienza guardando el valor
%del estado final; se busca su posicion a traves del comando find
%Las posiciones de las filas se guardan en la matriz auxiliar M
    [row1,col1]=find(E(:,1)==Mof & E(:,2)==Cof & E(:,3)==Mef & E(:,4)==Cef & E(:,5)==Cf);
    R(1,1)=E(row1,1);
    R(1,2)=E(row1,2);
    R(1,3)=E(row1,3);
    R(1,4)=E(row1,4);
    R(1,5)=E(row1,5);
    M(1,1)=row1;
    
  %Para escibir en la matriz R se busca los estados anteriores
  %se escribe el estado y se busca el anterior
  %min sirve para imprimir el primero de los estados con el valor 
  %solicitado
  
    for k=1:1:30
     [row2,col2]=(find(E(:,1)==E((M(k,1)),6) & E(:,2)==E((M(k,1)),7) & E(:,3)==E((M(k,1)),8) & E(:,4)==E((M(k,1)),9) & E(:,5)==E((M(k,1)),10)));
     M(k+1,1)=min(row2);
    R(k+1,1)=E(M(k+1),1);
    R(k+1,2)=E(M(k+1),2);
    R(k+1,3)=E(M(k+1),3);
    R(k+1,4)=E(M(k+1),4);
    R(k+1,5)=E(M(k+1),5);
    if R(k+1,1)==Moi && R(k+1,2)==Coi && R(k+1,3)==Mei && R(k+1,4)==Cei && R(k+1,5)==Ci
       % fprintf('\n Imprima matriz R \n');
        break;
    end
        
    end
    
    for l=1:size(R)
        Respuesta(l,1)=R(size(R,1)+1-l,1);
        Respuesta(l,2)=R(size(R,1)+1-l,2);
        Respuesta(l,3)=R(size(R,1)+1-l,3);
        Respuesta(l,4)=R(size(R,1)+1-l,4);
        Respuesta(l,5)=R(size(R,1)+1-l,5);
        
    end
    Respuesta
    
toc
  
   
How to append datasets when type and length are not the same                                                    
                                                                                                                
Age is numeric in the master dataset and character in the new data                                              
                                                                                                                
github                                                                                                          
http://tinyurl.com/y2xcuxv6                                                                                     
https://github.com/rogerjdeangelis/utl-how-to-append-datasets-when-type-and-length-are-not-the-same             
                                                                                                                
SAS Forum                                                                                                       
http://tinyurl.com/y4gvhzp2                                                                                     
https://communities.sas.com/t5/SAS-Programming/Change-variable-type-using-type/m-p/549079                       
                                                                                                                
*_                   _                                                                                          
(_)_ __  _ __  _   _| |_                                                                                        
| | '_ \| '_ \| | | | __|                                                                                       
| | | | | |_) | |_| | |_                                                                                        
|_|_| |_| .__/ \__,_|\__|                                                                                       
        |_|                                                                                                     
;                                                                                                               
                                                                                                                
data master;                                                                                                    
  set sashelp.class(obs=3 keep=name sex age where=(sex="F")) ;                                                  
run;quit;                                                                                                       
                                                                                                                
data new_data;                                                                                                  
  retain name sex age;                                                                                          
  set sashelp.class(obs=3 rename=age=agen                                                                       
   keep=name sex age where=(sex="M"));                                                                          
  age=put(agen,5.);                                                                                             
  drop agen;                                                                                                    
run;quit;                                                                                                       
                                                                                                                
Suppose work.numeric has the proper type and lengths                                                            
                                                                                                                
WORK.MASTER                                                                                                     
                                                                                                                
 Variables in Creation Order                                                                                    
                                                                                                                
#    Variable    Type    Len                                                                                    
                                                                                                                
1    NAME        Char      8                                                                                    
2    SEX         Char      1                                                                                    
                                                                                                                
3    AGE         Num       8  ** Numeric                                                                        
                                                                                                                
BUT WORK.NEW_DATA DOES NOT                                                                                      
                                                                                                                
 Variables in Creation Order                                                                                    
                                                                                                                
#    Variable    Type    Len                                                                                    
                                                                                                                
1    NAME        Char      8                                                                                    
2    SEX         Char      1                                                                                    
                                                                                                                
3    AGE         Char      5   ** Should be numeric                                                             
                                                                                                                
*                                                                                                               
 _ __  _ __ ___   ___ ___  ___ ___                                                                              
| '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                             
| |_) | | | (_) | (_|  __/\__ \__ \                                                                             
| .__/|_|  \___/ \___\___||___/___/                                                                             
|_|                                                                                                             
;                                                                                                               
                                                                                                                
* this has the added benefit that char variables will have the longer length;                                   
                                                                                                                
proc sql;                                                                                                       
  create                                                                                                        
      table want as                                                                                             
  select                                                                                                        
      *                                                                                                         
  from                                                                                                          
      master                                                                                                    
  oUter                                                                                                         
      union corr                                                                                                
  select                                                                                                        
      name                                                                                                      
      ,sex                                                                                                      
      ,input(age,5.) as age                                                                                     
  from                                                                                                          
     new_data                                                                                                   
;quit;                                                                                                          
                                                                                                                
*            _               _                                                                                  
  ___  _   _| |_ _ __  _   _| |_                                                                                
 / _ \| | | | __| '_ \| | | | __|                                                                               
| (_) | |_| | |_| |_) | |_| | |_                                                                                
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                               
                |_|                                                                                             
;                                                                                                               
                                                                                                                
 Variables in Creation Order                                                                                    
                                                                                                                
#    Variable    Type    Len                                                                                    
                                                                                                                
1    NAME        Char      8                                                                                    
2    SEX         Char      1                                                                                    
                                                                                                                
3    AGE         Num       8  * all numeric                                                                     
                                                                                                                
                                                                                                                
Up to 40 obs WORK.WANT total obs=6                                                                              
                                                                                                                
Obs     NAME      SEX    AGE(ALL NUMERIC)                                                                       
                                                                                                                
 1     Alice       F      13                                                                                    
 2     Barbara     F      13                                                                                    
 3     Carol       F      14                                                                                    
                                                                                                                
 4     Alfred      M      14                                                                                    
 5     Henry       M      14                                                                                    
 6     James       M      12                                                                                    
                                                                                                                
                                                                                                                

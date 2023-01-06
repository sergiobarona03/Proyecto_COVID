

#####################
## 400_covariables ##
#####################

# Nota: por simplicidad, recurro a la base de datos de la fecha final

larger_dataset = read.csv("D:\\Desktop\\Subset_5\\2021-11-30.csv")

# función de recodificación
funcion_w_n = function(a){
  dataset_0 = data.frame()
  colnames(a) <- c("Fecha_reporte", "Caso", "Not", "Cod_Dep", "Nom_Dep", "Cod_Mun",  
                   "Nom_Mun", "Edad", "Unidad", "Sexo", "Fuente", "Ubic", "Estado", 
                   "Pais_cod", "Pais_nom", "Dic_Recup",
                   "Inicio", "Muerte", "Diagnos", "Recup", "Tipo", "Pert_Etn", "Nom_Etn")
  a <- a[,-1]
  a$Caso = as.character(a$Caso)
  a$Caso = as.numeric(gsub(",", ".", a$Caso))
  a$Sexo <- as.factor(a$Sexo)
  #a$Not <- as.Date(as.POSIXct(a$Not, "UTC"))
  a$Cod_Mun <- as.numeric(a$Cod_Mun)
  a$Fuente <- as.factor(a$Fuente)
  
  a$Ubic <- as.factor(a$Ubic)
  a$Ubic <- as.character(a$Ubic)
  
  a$Pais_nom <- as.character(a$Pais_nom)
  
  a$Estado <- as.factor(a$Estado)
  
  a$Fuente <- revalue(a$Fuente, c("EN ESTUDIO" = "En estudio",
                                  "Relacionado" = "Relacionado"))
  
  a$Estado <- revalue(a$Estado, c("AsintomÃ¡tico = AsintomÃ¡tico", "Fallecido" = "Fallecido",
                                  "Grave" = "Grave", "Leve" = "Leve", "Moderado" = "Moderado",
                                  "N/A" = NA))
  a <- a[order(a$Caso),]
  a <- a[a$Cod_Mun == 76001, ]
  dataset_0 = a
  return(dataset_0)
}

# larger_dataset
larger_dataset = funcion_w_n(larger_dataset)

# Guardar larger_dataset
saveRDS(larger_dataset, "D:\\Desktop\\Subset_5\\Resultado\\larger_dataset.RDS")



# recuperar sexo y edad









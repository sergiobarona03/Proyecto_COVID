 

#############################
## 110_recodificar_valores ##
#############################

# convertir las variables en chr

for (k in 2:ncol(dataset_na)) {
  dataset_na[,k] = as.character(dataset_na[,k])
}


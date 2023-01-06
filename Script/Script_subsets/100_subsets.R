###############################
## Merge (subset_1:subset_5) ##
###############################

library(readxl)
library(dplyr)

destfile = vector()
n = 6 #número de subconjuntos

for (j in 1:n)
{
  destfile [[j]] =paste0(
    "D:\\Desktop\\[Proyecto M] Revisión_de_literatura\\Pruebas_actuales\\dataframe_subset_",
    j,".csv")
}


df_subset_1 = read.csv(destfile[1])
df_subset_2 = read.csv(destfile[2])
df_subset_3 = read.csv(destfile[3])
df_subset_4 = read.csv(destfile[4])
df_subset_5 = read.csv(destfile[5])
df_subset_6 = read.csv(destfile[length(destfile)])

aux_0 = list(df_subset_1, df_subset_2, df_subset_3, df_subset_4, df_subset_5,
             df_subset_6)

# Recodificar los nombres de las variables
for (k in 2:length(aux_0)) {
  colnames(aux_0[[k]]) = c("Caso", 
                  paste0("c_",9+k),
                  paste0("h_",9+k),
                  paste0("f_",9+k),
                  paste0("u_",9+k),
                  paste("r_",9+k),
                  paste("n_",9+k))

}

# Recodificar base de datos extensa
cas = vector(length = 10) 
hos =vector(length = 10) 
fal =vector(length = 10) 
uci =vector(length = 10) 
rec =vector(length = 10) 
noc =vector(length = 10) 

for (j in 1:10) {
  cas[j] = paste0("c_",j)
  hos[j] = paste0("h_",j)
  fal[j] = paste0("f_",j)
  uci[j] = paste0("u_",j)
  rec[j] = paste0("r_",j)
  noc[j] = paste0("n_",j)
}

colnames(aux_0[[1]]) = c("Caso", cas,
                         hos, fal, uci, rec, noc)

# merge completo

dataset = merge(aux_0[[6]], aux_0[[5]], by = "Caso", all.x = TRUE)
dataset = merge(dataset, aux_0[[4]], by = "Caso", all.x = TRUE)
dataset = merge(dataset, aux_0[[3]], by = "Caso", all.x = TRUE)
dataset = merge(dataset, aux_0[[2]], by = "Caso", all.x = TRUE)
dataset = merge(dataset, aux_0[[1]], by = "Caso", all.x = TRUE)

# restricción para extraer pacientes en UCI
# procedimiento: se mantienen todas las filas en las cuales existe al menos un U_i no vacío

subset_uci = dataset[c("Caso", uci, "u_11", 
                       "u_12", "u_13", 
                       "u_14", "u_15")]

subset_uci_na = subset_uci[rowSums(is.na(subset_uci[,2:ncol(subset_uci)])) != ncol(subset_uci[,2:ncol(subset_uci)]), ]

dataset_na = dataset %>% filter(Caso %in% subset_uci_na$Caso)

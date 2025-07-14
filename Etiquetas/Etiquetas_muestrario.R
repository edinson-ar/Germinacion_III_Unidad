source("https://inkaverse.com/setup.r")

# Cargar librerías necesarias

library(googlesheets4)
library(dplyr)
library(huito)

#cargar datos

url <- "https://docs.google.com/spreadsheets/d/1U1E1KG24riyl6k8N9OEnA6D7XXBYGjbReNyuSScV_s0/edit?gid=0#gid=0"

gs <- as_sheets_id(url)
fb <- range_read(gs, sheet = "fb")

View(fb)


#crear etiquetas

font <- c("Permanent Marker", "Tillana", "Courgette")

huito_fonts(font)


#etiquetas

label <- fb %>% 
  rename("scientific.name" = "n_cientifico", "name" = "n_comun") %>% 
  mutate(barcode = paste(qr)) %>% 
  
  label_layout(
    size = c(4.5, 2.7),
    border_color = "darkgreen"
    ) %>% 
  
  include_image(
    value = "https://www.untrm.edu.pe/assets/images/untrmazul.png"
    , size = c(1.4, 0.8)
    , position = c(3.4, 2.3)
    
    ) %>% 
  include_image(
    value = "logo_fica.jpg"
    , size = c(1.5, 0.9)
    , position = c(3.5, 1.5)
    
  ) %>% 
  include_barcode(
    value = "barcode"
    , size = c(2, 2)
    , position = c(1.1, 1.65)
  ) %>% 
  include_text(value = "Orden:"
               , position = c(3, 0.5)
               , size = 5
               , color = "blue"
               , opts = list(hjust = 0)
  ) %>% 
  include_text(value = "orden"
               , position = c(3.55, 0.5)
               , size = 5
               , color = "blue"
               , opts = list(hjust = 0)
  ) %>% 
  include_text(value = "Fam:"
               , position = c(0.3, 0.5)
               , size = 5
               , color = "blue"
               , opts = list(hjust = 0)
  ) %>% 
  include_text(value = "fam"
               , position = c(0.9, 0.5)
               , size = 5
               , color = "blue"
               , opts = list(hjust = 0)
  ) %>% 
  include_text(value = "scientific.name"
               , position = c(1.8, 0.3)
               , size = 5
               , color = "red"
               , font[2] 
  ) %>% 
  include_text(value = "name"
               , position = c(4, 0.3)
               , size = 5
               , color = "red"
               , font[2]
  )


#vista previa

label %>% 
  label_print()

label %>% label_print(mode = "c")

#modelo completo

#label %>% 
  #label_print(mode = "complete", filename = "germinar_et", nlabels = 40)

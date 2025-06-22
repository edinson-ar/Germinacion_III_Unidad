source("https://inkaverse.com/setup.r")

# Cargar librerías necesarias

library(googlesheets4)
library(dplyr)
library(huito)

#cargar datos

url <- "https://docs.google.com/spreadsheets/d/1clA0TdvpeIv2PDiLcT7SQB4Aiy-Bbx2BUDXObOCL2R4/edit?gid=475050723#gid=475050723"

gs <- as_sheets_id(url)
fb <- range_read(gs, sheet = "fb")

View(fb)


#crear etiquetas

font <- c("Permanent Marker", "Tillana", "Courgette")

huito_fonts(font)

#imagenes por especie

# Agregar una columna con las imágenes por especie
fb <- fb %>%
  mutate(
    color = case_when(
      Especie == "Frijol" ~ "blue",
      Especie == "Soja" ~ "red"
    ),
    imagen_especie = case_when(
      Especie == "Frijol" ~ "https://eos.com/wp-content/uploads/2024/03/growing-bean-pods.png.webp",
      Especie == "Soja" ~ "https://panorama-agro.com/wp-content/uploads/2017/10/Portada-soya-2f.jpg"
    )
  )

#etiquetas 

label <- fb %>% 
  mutate(color = case_when(
    Especie %in% "Frijol" ~ "blue"
    , Especie %in% "Soja" ~ "red"
  )) %>% 
  label_layout(size = c(5, 3)
               , border_color = "blue"
  ) %>%
  include_barcode(
    value = "qrcode"
    , size = c(1.6, 1.6)
    , position = c(4.2, 1.5)
  ) %>%
  include_text(value = "NaCl"
               , position = c(0.5, 0.6)
               , size = 5
               , color = "#009966"
               , font[2]
  ) %>%
  include_text(value = "Especie"
               , position = c(2.9, 0.6)
               , size = 5
               , color = "#009966"
               , font[3]
  ) %>% 
  include_text(value = "plots"
               , position = c(0.35, 2.6)
               , angle = 0
               , size = 5
               , color = "red"
               , font[1]
  ) %>%
  include_text(value = "Ingeniería Agrónoma"
               , position = c(2.2, 2.6)
               , angle = 0
               , size = 5
               , color = "black"
               , font[1]
  ) %>%
  include_text(value = "ntreat"
               , position = c(1.8, 0.6)
               , angle = 0
               , size = 5
               , color = "red"
               , font[1]
  ) %>%
  include_image(
    value = "https://www.untrm.edu.pe/assets/images/untrmazul.png",
    size = c(1.5, 0.8),
    position = c(4.2, 0.38)
  ) %>%
  include_image(
    value = "imagen_especie",
    size = c(2.95, 3.1),
    position = c(1.7, 1.5)
  ) %>% 
  include_image(
    value = "logo_fica.jpg",
    size = c(1.5, 0.59),
    position = c(4.2, 2.6)
  )

#vista previa

label %>% 
  label_print()

#modelo completo

label %>% 
  label_print(mode = "complete", filename = "germinar_et", nlabels = 40)

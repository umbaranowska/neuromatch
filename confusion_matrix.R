library(tidyverse)
library(magrittr)

matrix = readxl::read_excel("matrix.xlsx", col_names = TRUE)

plot_matrix = matrix %>% reshape2::melt() %>%
  mutate(labelled = case_when(...1 == 'label_novel' ~ 'novel',
                              ...1 == 'label_familiar' ~ 'familiar'),
         actual = case_when(variable == 'true_novel' ~ 'novel',
                            variable == 'true_familiar' ~ 'familiar'))

png('matrix.png', 800, 600)
ggplot(plot_matrix, aes(x = actual, y = labelled, fill = value)) +
  geom_tile() +
  xlab('True category') +
  ylab('Labelled category') +
  geom_text(aes(label = value), color = 'white', size = 8) +
  theme_bw() +
  theme(title = element_text(size=20),
        axis.text = element_text(size=20),
        axis.text.x = element_text(vjust = 0.75),
        axis.title = element_text(size=20),
        legend.position = 'none',
        strip.text = element_text(size=20))
dev.off()

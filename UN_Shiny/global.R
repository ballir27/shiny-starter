library(shiny)
library(tidyverse)


gdp_df <- read_csv('data/gdp_per_capita.csv')
continents <- read_csv('data/continents.csv')
life_expectancy <- read_csv('data/life_expectancy.csv', skip=4) %>%
  select(-c(`Country Code`, `Indicator Name`, `Indicator Code`)) %>% 
  rename_with(~c('Country'), `Country Name`)


gdp_df <- gdp_df %>%
  select(-c(`Value Footnotes`)) %>%
  rename_with(~c('GDP_Per_Capita'), Value) %>% 
  rename_with(~c('Country'), `Country or Area`)

gdp_df <- merge(continents, gdp_df, by = "Country", all = FALSE)

life_expectancy <- life_expectancy %>%
  pivot_longer(-Country) %>%
  rename_with(~c('Country','Year','Life_Expectancy'))

gdp_le <- merge(gdp_df, life_expectancy, by = c("Country","Year"), all = FALSE) %>%
  drop_na()

gdp_le_2019 <- gdp_le %>%
  filter(Year == 2019)

continent_choices <- gdp_le_2019 %>% 
  pull(Continent) %>% 
  unique()

continent_choices <- c("All Continents", continent_choices)

# #3) Which years are represented in this dataset? How many observations are there per year? Make a plot to view the number of observations per year.
# 
# gdp_df %>% 
#   summarize(num_years = n_distinct(Year))
# 
# gdp_df %>% 
#   group_by(Year) %>% 
#   count()
# 
# 
# gdp_df %>% 
#   group_by(Year) %>% 
#   summarize(Count = n()) %>% 
#   ggplot(aes(x=Year, y=Count)) + geom_point() +geom_line()
# 
# #Create a new dataframe by subsetting gdp_df to just the year 2014. Call this new dataframe gdp_2014.
# 
# gdp_2014 <- gdp_df %>% 
#   filter(Year == 2014)
# 
# gdp_2014 %>%
#   ggplot(aes(x = GDP_Per_Capita)) +
#   geom_histogram(bins=30, color="black", fill="blue") +
#   labs(title = "GDP Per Capita for 2014") +
#   theme(plot.title = element_text(hjust = 0.5))

#8) Find the top 5 counties and bottom 5 countries by GDP per capita in 2014.
# gdp_2014 %>% 
#   arrange(desc(GDP_Per_Capita)) %>%
#   head()
# gdp_2014 %>% 
#   arrange(desc(GDP_Per_Capita)) %>%
#   tail()

#9) Now, return to the full dataset, gdp_df. Pivot the data for 1990 and 2018 (using the pandas .pivot_wider() method or another method) so that each row corresponds to a country, each column corresponds to a year, and the values in the table give the GDP_Per_Capita amount. Drop any rows that are missing values for either 1990 or 2018. Save the result to a dataframe named gdp_pivoted.
# gdp_pivoted <- gdp_df %>% 
#   pivot_wider(names_from = Year, values_from = GDP_Per_Capita) %>% 
#   select(`Country or Area`, `1990`, `2018`) %>%
#   drop_na()


#10) Create a new column in gdp_pivoted named Percent_Change. This column should contain the percent change in GDP_Per_Capita from 1990 to 2018. Hint: Percent change is calculated as 100*(New Value - Old Value) / Old Value.

#11) How many countries experienced a negative percent change in GDP per capita from 1990 to 2018?

#12) Which country had the highest % change in GDP per capita? Create a line plot showing these country's GDP per capita for all years for which you have data. Put both line charts on the same plot.
# 
# gdp_pivoted <- gdp_pivoted %>% 
#   mutate(Percent_Change = 100 * (`2018`-`1990`)/`1990`)
# 
# gdp_pivoted %>% 
#   filter(Percent_Change<0)
# 
# gdp_pivoted %>% 
#   arrange(desc(Percent_Change)) %>% 
#   head()
# 
# gdp_df %>% 
#   filter(`Country or Area` %in% c('Equatorial Guinea', 'China', 'Myanmar')) %>% 
#   ggplot(aes(x=Year, y=GDP_Per_Capita, color = `Country or Area`)) +
#   geom_line() + geom_point()
# ```
# Same thing in a different way:
# ```{r}
# top_countries <- gdp_pivoted %>% 
#   slice_max(order_by = Percent_Change, n=3) %>% 
#   pull(`Country or Area`)
# 
# gdp_df %>% 
#   filter(`Country or Area` %in% top_countries) %>% 
#   ggplot(aes(x = Year, y = GDP_Per_Capita, color = `Country or Area`)) +
#   geom_line() + geom_point()
# ```

#15) Determine the number of countries per continent. Create a bar chart showing this.
# gdp_df %>% 
#   group_by(Continent) %>% 
#   summarize(num_countries = n_distinct(Country)) %>% 
#   ggplot(aes(x = Continent, y = num_countries, fill = Continent)) +
#   geom_col() +
#   geom_text(aes(label = num_countries), vjust = -.2)

#16) Create a boxplot showing GDP per capita in 2018 split out by continent. What do you notice?
# gdp_df %>%
#   filter(Year == 2018) %>% 
#   ggplot(aes(x = Continent, y = GDP_Per_Capita, fill = Continent)) +
#   geom_boxplot() +
#   stat_boxplot(geom='errorbar')


# 23) Create a scatter plot of Life Expectancy vs GDP per Capita for the year 2019. What do you notice?
# ggplot(gdp_le_2019, aes(x=GDP_Per_Capita, y = Life_Expectancy, color = Continent)) + geom_point()

# 24) Find the correlation between Life Expectancy and GDP per Capita for the year 2019. What is the meaning of this number?
# ```{r}
# gdp_le_2019 %>% 
#   select(GDP_Per_Capita, Life_Expectancy) %>% 
#   cor()
# ```
# 25) Add a column to gdp_le_2019 and calculate the logarithm of GDP per capita. Find the correlation between the log of GDP per capita and life expectancy. How does this compare to the calculation in the previous part? Look at a scatter plot to see if the result of this calculation makes sense.
# ```{r}
# ggplot(gdp_le_2019, aes(x=GDP_Per_Capita, y = Life_Expectancy, color = Continent)) + geom_point() + scale_x_log10()
# ```
# ```{r}
# gdp_le_2019 <- gdp_le_2019 %>% 
#   mutate(Log10_GDP_Per_Capita = log10(GDP_Per_Capita))
# 
# gdp_le_2019 %>% 
#   head()
# 
# gdp_le_2019 %>% 
#   select(GDP_Per_Capita, Log10_GDP_Per_Capita, Life_Expectancy) %>% 
#   cor()
# ```
# ```{r}
# ggplot(gdp_le_2019, aes(x=Log10_GDP_Per_Capita, y = Life_Expectancy, color = Continent)) + geom_point()
# ```
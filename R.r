# Load necessary libraries
library(ggplot2)  # For advanced plotting
library(dplyr)    # For data manipulation

# Load the dataset
data <- read.csv("/mnt/data/weatherHistory.csv")

# Check the first few rows of the dataset
head(data)

# Basic exploratory data analysis
summary(data)

# Example: Visualizing Temperature Over Time

# 1. Line Graph: Temperature vs. Date
ggplot(data, aes(x = as.Date(formattedDate), y = Temperature)) +
  geom_line(color = "blue") +
  labs(title = "Temperature Over Time", x = "Date", y = "Temperature") +
  theme_minimal()

# 2. Histogram: Distribution of Temperature
ggplot(data, aes(x = Temperature)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black") +
  labs(title = "Temperature Distribution", x = "Temperature", y = "Frequency") +
  theme_minimal()

# 3. Scatter Plot: Temperature vs. Humidity
ggplot(data, aes(x = Humidity, y = Temperature)) +
  geom_point(color = "red") +
  labs(title = "Temperature vs. Humidity", x = "Humidity", y = "Temperature") +
  theme_minimal()

# 4. Bar Plot: Average Temperature by Summary (Weather Condition)
data %>%
  group_by(Summary) %>%
  summarise(avg_temp = mean(Temperature)) %>%
  ggplot(aes(x = reorder(Summary, -avg_temp), y = avg_temp)) +
  geom_bar(stat = "identity", fill = "green") +
  labs(title = "Average Temperature by Weather Condition", x = "Weather Condition", y = "Average Temperature") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# 5. Boxplot: Temperature by Precipitation
ggplot(data, aes(x = PrecipType, y = Temperature)) +
  geom_boxplot() +
  labs(title = "Temperature by Precipitation Type", x = "Precipitation Type", y = "Temperature") +
  theme_minimal()
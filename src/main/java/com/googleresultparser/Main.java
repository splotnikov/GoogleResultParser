package com.googleresultparser;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class Main {

	public static void main(String[] args) {
		String url = "http://www.google.com";

		System.out.println("Type your search request: ");
		Scanner scanner = new Scanner(System.in);
		String searchRequest = scanner.nextLine();

		WebDriver driver = new FirefoxDriver();
		driver.get(url);
		WebElement element = driver.findElement(By.name("q"));
		element.sendKeys(searchRequest);
		element.submit();
		
		WebDriverWait wait = new WebDriverWait(driver, 60);
		wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//h3[@class='r']/a")));
		
		List<String> hrefs = new ArrayList<String>();
		List<WebElement> links = driver.findElements(By.xpath("//h3[@class='r']/a"));
		
		for (WebElement link : links) {
			hrefs.add(link.getAttribute("href"));
		}

		for (String href : hrefs) {
			driver.navigate().to(href);
			System.out.println(driver.getTitle());
		}
		
		driver.close();
	}
}
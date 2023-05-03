package kr.book.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor  
@NoArgsConstructor
public class Book {

	private int num;
	private String title;
	private String author;
	private String company;
	private String lsbn; 
	private int count;
	
	
	
}

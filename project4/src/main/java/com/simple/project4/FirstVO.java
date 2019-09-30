package com.simple.project4;

public class FirstVO {
	
	private String type;
	private String name;
	private String address;
	private String site;
	private String content;
	
	private int seq;
	private int price;
	
	public FirstVO() {}

	public FirstVO(String type, String name, String address, String site, String content, int seq, int price) {
		super();
		this.type = type;
		this.name = name;
		this.address = address;
		this.site = site;
		this.content = content;
		this.seq = seq;
		this.price = price;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getSite() {
		return site;
	}

	public void setSite(String site) {
		this.site = site;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}
	
	
	

}

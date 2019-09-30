--숙소리스트         /이름,주소,사이트,가격,비고
--관광지리스트       /이름,주소,사이트,가격,비고 
--예상예산리스트     /제목,내용,가격  
CREATE TABLE p4mapList(
    type VARCHAR2(40) NOT NULL,
    name VARCHAR2(40) NOT NULL,
    address VARCHAR2(100) NOT NULL,
    site VARCHAR2(200),
    price NUMBER(10) NOT NULL,
    content VARCHAR2(4000)
);

CREATE TABLE p4priceList(
    seq NUMBER(10) NOT NULL,
    name VARCHAR2(40) NOT NULL,
    price NUMBER(10) NOT NULL,
    content VARCHAR2(4000)
);

insert into p4priceList VALUES(1,'항공',0,'');
insert into p4priceList VALUES(2,'숙소',0,'');
insert into p4priceList VALUES(3,'렌트',0,'');
insert into p4priceList VALUES(4,'관광',0,'');
insert into p4priceList VALUES(5,'식비',0,'');
insert into p4priceList VALUES(6,'쇼핑',0,'');
select * from p4priceList;

commit;
CREATE DATABASE orders;
go

USE orders;
go

DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(150),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);




INSERT INTO category(categoryName) VALUES ('Running Shoes');
INSERT INTO category(categoryName) VALUES ('Walking Shoes');
INSERT INTO category(categoryName) VALUES ('Sneakers');
INSERT INTO category(categoryName) VALUES ('Skateboarding Shoes');
INSERT INTO category(categoryName) VALUES ('Basketball Shoes');
INSERT INTO category(categoryName) VALUES ('Hiking Shoes');
INSERT INTO category(categoryName) VALUES ('Boots');
INSERT INTO category(categoryName) VALUES ('Low Tops');


-- Shoe-related product data
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL,productImage) VALUES ('Nike Air Max', 1, 'Running shoes', 89.99, 'https://static.nike.com/a/images/f_auto,cs_srgb/w_1536,c_limit/6f806266-4f96-4135-b23c-fc99088b76c9/nike-air-max.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Puma Thunder', 3, 'Casual sneakers', 79.99, 'https://cdn-images.farfetch-contents.com/12/96/10/00/12961000_13556762_600.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Adidas Ultraboost', 1, 'Performance running shoes', 129.99, 'https://assets.adidas.com/images/w_600,f_auto,q_auto/8ba2e2cad8bc468bb001af160002bb95_9366/Ultraboost_1.0_Shoes_Black_HQ4201_01_standard.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('New Balance 990', 1, 'Classic trainers', 109.99, 'https://images.squarespace-cdn.com/content/v1/5739782920c6471cf06b0e00/1668451685651-T99EZRX63R9XZWDEK0TO/thumbnail_IMG_6413.jpg?format=1000w');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Vans Old Skool', 4, 'Skateboarding shoes', 59.99, 'https://media-www.sportchek.ca/product/div-05-footwear/dpt-80-footwear/sdpt-01-mens/333860752/vans-old-skool-chocolate-gum-722-m-3ec210d0-1ed7-49b9-9905-b98cf7a80a28-jpgrendition.jpg?imdensity=1&imwidth=1244&impolicy=mZoom');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Converse Chuck Taylor', 3, 'Canvas sneakers', 49.99, 'https://converse.ca/media/catalog/product/cache/7675cebc3e2f09ee2a340c17d68ace33/m/9/m9160_a_107x1_1_2nd.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Reebok Classic Leather', 3, 'Heritage shoes', 69.99, 'https://reebok.ca/cdn/shop/products/HQ2233B0089.jpg?v=1676687243&width=500');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Under Armour HOVR', 5, 'Basketball shoes', 79.99, 'https://media-www.sportchek.ca/product/div-05-footwear/dpt-80-footwear/sdpt-01-mens/333777725/under-armour-hovr-rise-4-blk-gry-722-m-e2a57b0d-f5b6-4639-a4a9-4340a15ace03-jpgrendition.jpg?imdensity=1&imwidth=1244&impolicy=mZoom');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Skechers Go Walk', 2, 'Walking shoes', 54.99, 'https://www.skechers.ca/dw/image/v2/BDCN_PRD/on/demandware.static/-/Sites-skechers-master/default/dw1527bd73/images/large/125207_NVLB.jpg?sw=800');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Brooks Ghost', 1, 'Neutral running shoes', 119.99, 'https://shoeper.com/cdn/shop/products/1203561D446-2.jpg?v=1636652432');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('ASICS Gel-Kayano', 1, 'Long-distance running shoes', 139.99, 'https://size.ca/cdn/shop/files/1202A056-300_asics_women_s_gel_kayano_14_bright_lime__midnight_1_900x.jpg?v=1692267536');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Fila Disruptor', 3, 'Fashion sneakers', 69.99, 'https://boathousestores.com/cdn/shop/files/FIA-5XM02263-400-BLU-2.jpg?v=1699543369&width=1000');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Merrell Moab', 6, 'Hiking shoes', 89.99, 'https://www.sail.ca/media/catalog/product/w/o/wolverin-j035893_walnut__01.jpg?quality=80&bg-color=255,255,255&fit=bounds&height=700&width=700&canvas=700:700');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Timberland 6-Inch Boot', 7, 'Classic work boots', 129.99, 'https://boathousestores.com/cdn/shop/files/TIM-TB010061713-WHE-1.jpg?v=1693487766&width=1000');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Dr. Martens 1460', 7, 'Combat boots', 119.99, 'https://cdn.media.amplience.net/i/drmartens/21975001.82?$smart576$&fmt=auto');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Clarks Originals Desert Boot', 7, 'Chukka boots', 99.99, 'https://m.media-amazon.com/images/I/51dMTF80cxL._AC_UY780_.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('UGG Classic Short', 7, 'Sheepskin boots', 149.99, 'https://dms.deckers.com/ugg/image/upload/f_auto,q_auto,dpr_auto/b_rgb:eeeeee/w_1008/v1663844567/catalog/images/transparent/1016223-CHE_1.png?_s=RAABAB0');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Saucony Jazz Original', 1, 'Vintage running shoes', 64.99, 'https://i.ebayimg.com/images/g/tJIAAOSwmatkAf23/s-l1200.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Hoka One One Bondi', 1, 'Maximalist running shoes', 149.99, 'https://ca.shop.runningroom.com/media/catalog/product/cache/623252543a71a417af50138275bda2d9/1/0/1019269-bisb_r.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Brooks Adrenaline GTS', 1, 'Stability running shoes', 129.99, 'https://www.brooksrunning.com/dw/image/v2/BGPF_PRD/on/demandware.static/-/Sites-brooks-master-catalog/default/dwa4567802/original/110391/110391-065-a-adrenaline-gts-23-mens-supportive-cushion-running-shoe.jpg?sw=425&sh=425&sm=fit&sfrm=png&bgcolor=F1F3F6');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Nike React Infinity Run', 1, 'Cushioned running shoes', 109.99, 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/45544e10-1e4c-437d-8340-dc4e9a9fbead/react-infinity-run-flyknit-3-road-running-shoes-sqDvTF.png');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Puma Cali', 3, 'Lifestyle sneakers', 69.99, 'https://boathousestores.com/cdn/shop/files/PUM-393802-01-W.B-1.jpg?v=1692627826&width=1000');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Adidas Superstar', 8, 'Iconic shell-toe shoes', 79.99, 'https://images.journeys.ca/images/products/1_581847_FS.JPG');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('New Balance 574', 8, 'Classic lifestyle shoes', 89.99, 'https://www.beckershoes.com/media/catalog/product/cache/b108f5ddeb9ab1250e28312969076759/w/l/wl574evw_105.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Vans Sk8-Hi', 4, 'High-top skate shoes', 64.99, 'https://sportuptown.com/cdn/shop/files/5AC03AF9-481D-4539-98F9-0D709D6724D5.jpg?v=1697389893');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Converse One Star', 8, 'Casual low-top sneakers', 59.99, 'https://i.ebayimg.com/images/g/cY0AAOSwtpZhSqIo/s-l1200.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Reebok Nano X', 3, 'Cross-training shoes', 99.99, 'https://reebok.ca/cdn/shop/products/1tt_Eala0CepiQR9olQ1IjSJj_0CYAPpF.jpg?v=1663433210&width=1445');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Under Armour Curry 8', 5, 'Basketball performance shoes', 129.99, 'https://m.media-amazon.com/images/I/61oNkq8EjIL._AC_UY300_.jpg');


INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 18);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 19);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 10);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 22);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 21.35);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 25);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 30);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 40);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 97);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 31);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , '304Arnold!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , '304Bobby!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , '304Candace!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , '304Darren!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , '304Beth!');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

-- Order 3 cannot be shipped as do not have enough inventory for item 7
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);


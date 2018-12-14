create schema if not exists inventory collate latin1_swedish_ci;

create table if not exists customers
(
	id int auto_increment
		primary key,
	first_name varchar(255) not null,
	last_name varchar(255) not null,
	email varchar(255) not null,
	constraint email
		unique (email)
);

create table if not exists addresses
(
	id int auto_increment
		primary key,
	customer_id int not null,
	street varchar(255) not null,
	city varchar(255) not null,
	state varchar(255) not null,
	zip varchar(255) not null,
	type enum('SHIPPING', 'BILLING', 'LIVING') not null,
	constraint addresses_ibfk_1
		foreign key (customer_id) references customers (id)
);

create index address_customer
	on addresses (customer_id);

create table if not exists products
(
	id int auto_increment
		primary key,
	name varchar(255) not null,
	description varchar(512) null,
	weight float null
);

create table if not exists orders
(
	order_number int auto_increment
		primary key,
	order_date date not null,
	purchaser int not null,
	quantity int not null,
	product_id int not null,
	constraint orders_ibfk_1
		foreign key (purchaser) references customers (id),
	constraint orders_ibfk_2
		foreign key (product_id) references products (id)
);

create index order_customer
	on orders (purchaser);

create index ordered_product
	on orders (product_id);

create table if not exists products_on_hand
(
	product_id int not null
		primary key,
	quantity int not null,
	constraint products_on_hand_ibfk_1
		foreign key (product_id) references products (id)
);


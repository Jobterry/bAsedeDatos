CREATE SCHEMA sale;
CREATE SCHEMA users;
CREATE SCHEMA store;
CREATE SCHEMA buys;
CREATE SCHEMA promotion;

CREATE TABLE sale.sale(
	id SERIAL,
	id_users INTEGER NOT NULL,
	id_client INTEGER NOT NULL,
	id_detail INTEGER NOT NULL,
	date_sale DATE DEFAULT CURRENT_TIMESTAMP,
	stock INTEGER NULL,

	CONSTRAINT pk_sale PRIMARY KEY(id),
	CONSTRAINT fk_users_users FOREIGN KEY(id_users) REFERENCES users.users(id),
	CONSTRAINT fk_sale_client FOREIGN KEY(id_client) REFERENCES sale.client(id),
	CONSTRAINT fk_sale_detail FOREIGN KEY(id_detail) REFERENCES sale.sale_detail(id),
	CONSTRAINT stock_valid CHECK (stock >= 0)
);

CREATE TABLE sale.client(
	id SERIAL,
	name_client TEXT NOT NULL,

	CONSTRAINT pk_client PRIMARY KEY(id)
);

CREATE TABLE sale.sale_detail(
	id SERIAL,
	id_item INTEGER NOT NULL,
	cost_detail INTEGER NOT NULL,
	amount INTEGER NULL,

	CONSTRAINT pk_detail PRIMARY KEY(id),
	CONSTRAINT fk_store_item FOREIGN KEY(id_item) REFERENCES store.item(id),
	CONSTRAINT amount_valid CHECK (amount >= 0)
);

CREATE TABLE store.store(
	id SERIAL,
	id_users INTEGER NOT NULL,
	id_item INTEGER NOT NULL,
	date_store DATE DEFAULT CURRENT_TIMESTAMP,
	motion CHAR(1) NOT NULL,
	amount_store INTEGER NULL,
	final_amount INTEGER NULL,

	CONSTRAINT pk_store PRIMARY KEY(id),
	CONSTRAINT fk_users_users FOREIGN KEY(id_users) REFERENCES users.users(id),
	CONSTRAINT fk_store_item FOREIGN KEY(id_item) REFERENCES store.item(id),
	CONSTRAINT amount_valid_store CHECK (amount_store >= 0),
	CONSTRAINT motion_valid CHECK (motion IN ('i', 's'))
);

CREATE TABLE store.item(
	id SERIAL,
	name_item TEXT NOT NULL,
	description_item TEXT NOT NULL,

	CONSTRAINT pk_item PRIMARY KEY(id)
);

CREATE TABLE users.users(
	id SERIAL,
	name_users TEXT NOT NULL,
	password_users TEXT NOT NULL,

	CONSTRAINT pk_users PRIMARY KEY(id)
);

CREATE TABLE users.employee (
    id SERIAL,
    id_users INTEGER NOT NULL,
    name_employee TEXT NOT NULL,
    ap_paterno TEXT NULL,
    ap_materno TEXT NULL,

    CONSTRAINT pk_users_employee PRIMARY KEY(id),
    CONSTRAINT fk_users_users FOREIGN KEY(id_users) REFERENCES users.users(id)
);


CREATE TABLE users.contract(
	id SERIAL,
	id_employee INTEGER NOT NULL,
	id_position INTEGER NOT NULL,
	date_contract DATE DEFAULT CURRENT_TIMESTAMP,
	type_contract TEXT NOT NULL,
	time_contrat INTEGER,
	
	CONSTRAINT pk_users_contract PRIMARY KEY(id),
	CONSTRAINT fk_users_employee FOREIGN KEY(id_employee) REFERENCES users.employee(id),
	CONSTRAINT fk_users_position FOREIGN KEY(id_position) REFERENCES users.position(id),
	CONSTRAINT time_valid CHECK (time_contrat > 0)
);

CREATE TABLE users.position(
	id SERIAL,
	name_position TEXT,
	description_position TEXT,

	CONSTRAINT pk_users_position PRIMARY KEY(id)
);

CREATE TABLE users.assing_area(
	id SERIAL,
	id_employee INTEGER NOT NULL,
	id_area INTEGER NOT NULL,

	CONSTRAINT pk_users_assing_area PRIMARY KEY(id),
	CONSTRAINT fk_users_employee FOREIGN KEY(id_employee) REFERENCES users.employee(id),
	CONSTRAINT fk_users_area FOREIGN KEY(id_area) REFERENCES users.area(id)
);

CREATE TABLE users.area(
	id SERIAL,
	location_area TEXT NOT NULL,
	description_area TEXT NULL,
	number_area INTEGER NOT NULL,

	CONSTRAINT pk_users_area PRIMARY KEY(id),
	CONSTRAINT number_valid CHECK (number_area > 0)
 );

CREATE TABLE users.control_access(
	id SERIAL,
	id_users INTEGER NOT NULL,
	admin_control_access TEXT NULL,
	buys_control_access TEXT NULL,
	sale_control_access TEXT NULL,
	store_control_access TEXT NULL,

	CONSTRAINT pk_users_control_access PRIMARY KEY(id),
	CONSTRAINT fk_users_users FOREIGN KEY(id_users) REFERENCES users.users(id)
);

CREATE TABLE buys.buys(
	id SERIAL,
	id_users INTEGER NOT NULL,
	id_buys_detail INTEGER NOT NULL,
	id_buys_supplier INTEGER NOT NULL,
	date_buys DATE DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT pk_buys PRIMARY KEY(id),
	CONSTRAINT fk_users_users FOREIGN KEY(id_users) REFERENCES users.users(id),
	CONSTRAINT fk_buys_detail FOREIGN KEY(id_buys_detail) REFERENCES buys.buys_detail(id),
	CONSTRAINT fk_buys_supplier FOREIGN KEY(id_buys_supplier) REFERENCES buys.buys_supplier(id)
);

CREATE TABLE buys.buys_detail(
	id SERIAL,
	id_item INTEGER NOT NULL,
	cost_detail INTEGER NOT NULL,
	amount_detail INTEGER NULL,

	CONSTRAINT pk_detail PRIMARY KEY(id),
	CONSTRAINT fk_store_item FOREIGN KEY(id_item) REFERENCES store.item(id),
	CONSTRAINT cost_valid CHECK (cost_detail >= 0),
	CONSTRAINT amount_valid CHECK (amount_detail >= 0)
);

CREATE TABLE buys.buys_supplier(
	id SERIAL,
	supplier_name TEXT NOT NULL,
	company_name TEXT NOT NULL,
	email TEXT NOT NULL,
	number_phone TEXT NOT NULL,

	CONSTRAINT pk_buys_supplier PRIMARY KEY(id)
);

CREATE TABLE promotion.promotion(
	id SERIAL,
	id_item INTEGER NOT NULL,
	date_promotion DATE DEFAULT CURRENT_TIMESTAMP,
	amount_promotion INTEGER NULL,
	discount INTEGER NULL,
	
	CONSTRAINT pk_promotion PRIMARY KEY(id),
	CONSTRAINT fk_store_item FOREIGN KEY(id_item) REFERENCES store.item(id),
	CONSTRAINT amount_valid CHECK (amount_promotion >= 0),
	CONSTRAINT discount_valid CHECK (discount > 0)
);
--SALE--
INSERT INTO sale.sale (id_users, id_client, id_detail, date_sale, stock) VALUES
(1, 1, 1, '2025-03-01', 90),
(2, 2, 2, '2025-03-02', 35),
(3, 3, 3, '2025-03-03', 0),
(4, 4, 4, '2025-03-04', 180),
(5, 5, 5, '2025-03-05', 60),
(6, 6, 6, '2025-03-06', 25),
(7, 7, 7, '2025-03-07', 50),
(8, 8, 8, '2025-03-08', 65),
(9, 9, 9, '2025-03-09', 10),
(10, 10, 10, '2025-03-10', 15),
(11, 11, 11, '2025-03-11', 100),
(12, 12, 12, '2025-03-12', 30),
(13, 13, 13, '2025-03-13', 0),
(14, 14, 14, '2025-03-14', 40),
(15, 15, 15, '2025-03-15', 50),
(16, 16, 16, '2025-03-16', 25),
(17, 17, 17, '2025-03-17', 120),
(18, 18, 18, '2025-03-18', 10),
(19, 19, 19, '2025-03-19', 30),
(20, 20, 20, '2025-03-20', 50),
(21, 21, 21, '2025-03-21', 20),
(22, 22, 22, '2025-03-22', 15),
(23, 23, 23, '2025-03-23', 0),
(24, 24, 24, '2025-03-24', 75),
(25, 25, 25, '2025-03-25', 15),
(26, 26, 26, '2025-03-26', 12),
(27, 27, 27, '2025-03-27', 18),
(28, 28, 28, '2025-03-28', 40),
(29, 29, 29, '2025-03-29', 100),
(30, 30, 30, '2025-03-30', 5);
INSERT INTO sale.sale_detail (id_item, cost_detail, amount) VALUES
(1, 500, 10),
(2, 700, 15),
(3, 300, 5),
(4, 1500, 20),
(5, 800, 8),
(6, 400, 25),
(7, 600, 12),
(8, 350, 10),
(9, 750, 7),
(10, 200, 20),
(11, 900, 15),
(12, 1100, 30),
(13, 450, 12),
(14, 350, 18),
(15, 600, 25),
(16, 1000, 30),
(17, 500, 20),
(18, 650, 10),
(19, 450, 30),
(20, 750, 18),
(21, 700, 12),
(22, 550, 25),
(23, 950, 20),
(24, 1200, 5),
(25, 500, 15),
(26, 350, 8),
(27, 600, 12),
(28, 700, 10),
(29, 800, 25),
(30, 1000, 5);
INSERT INTO sale.client (name_client) VALUES
('Juan Pérez'),
('Ana López'),
('Carlos Martínez'),
('Sofía García'),
('Luis Rodríguez'),
('María Fernández'),
('Pedro González'),
('Lucía Sánchez'),
('José Ramírez'),
('Marta Díaz'),
('Antonio Herrera'),
('Patricia Jiménez'),
('David Morales'),
('Raquel Vargas'),
('Manuel Ruiz'),
('Elena Castro'),
('Fernando Romero'),
('Isabel Torres'),
('Francisco Díaz'),
('Beatriz López'),
('Javier Navarro'),
('Carmen Ramos'),
('Héctor Díaz'),
('Teresa Jiménez'),
('Santiago Ortiz'),
('Adriana Pérez'),
('Ricardo García'),
('Lorena González'),
('Miguel Ángel García'),
('Juan Carlos Romero'),
('Verónica Sánchez');

--USERS--
INSERT INTO users.users (name_users, password_users) VALUES
('juan_perez', 'password123'),
('ana_lopez', 'securePass1'),
('carlos_martinez', '12345abc'),
('sofia_garcia', 'pass987'),
('luis_rodriguez', 'mypassword'),
('maria_fernandez', 'pass1234'),
('pedro_gonzalez', '1234secure'),
('lucia_sanchez', 'qwerty123'),
('jose_ramirez', 'abcde12345'),
('marta_diaz', 'password321'),
('antonio_herrera', 'Anto1234'),
('patricia_jimenez', 'Patr1c1a'),
('david_morales', 'davidpass'),
('raquel_vargas', 'Raquel123'),
('manuel_ruiz', 'Manuel@123'),
('elena_castro', 'Elena#456'),
('fernando_romero', 'F3rn4nd0!'),
('isabel_torres', 'Isabel1990'),
('francisco_diaz', 'Fr4nci5c0#'),
('beatriz_lopez', 'B3atriz_1990'),
('javier_navarro', 'Javi12345'),
('carmen_ramos', 'Carm3n#321'),
('hector_diaz', 'H3ctorPass'),
('teresa_jimenez', 'T3r3sa@2025'),
('santiago_ortiz', 'S4nt!@go'),
('adriana_perez', 'A5dr!ana'),
('ricardo_garcia', 'Ricard0_321'),
('lorena_gonzalez', 'L0rena#2025'),
('miguel_angel_garcia', 'M!guel123');
INSERT INTO users.employee (id_users, name_employee, ap_paterno, ap_materno) VALUES
(1, 'Juan Pérez', 'Pérez', 'García'),
(2, 'Ana López', 'López', 'Martínez'),
(3, 'Carlos Martínez', 'Martínez', 'Hernández'),
(4, 'Sofía García', 'García', 'Rodríguez'),
(5, 'Luis Rodríguez', 'Rodríguez', 'Pérez'),
(6, 'María Fernández', 'Fernández', 'López'),
(7, 'Pedro González', 'González', 'Torres'),
(8, 'Lucía Sánchez', 'Sánchez', 'Ramírez'),
(9, 'José Ramírez', 'Ramírez', 'González'),
(10, 'Marta Díaz', 'Díaz', 'Fernández'),
(11, 'Antonio Herrera', 'Herrera', 'Castro'),
(12, 'Patricia Jiménez', 'Jiménez', 'Díaz'),
(13, 'David Morales', 'Morales', 'López'),
(14, 'Raquel Vargas', 'Vargas', 'García'),
(15, 'Manuel Ruiz', 'Ruiz', 'Pérez'),
(16, 'Elena Castro', 'Castro', 'González'),
(17, 'Fernando Romero', 'Romero', 'Sánchez'),
(18, 'Isabel Torres', 'Torres', 'Hernández'),
(19, 'Francisco Díaz', 'Díaz', 'Martínez'),
(20, 'Beatriz López', 'López', 'Pérez'),
(21, 'Javier Navarro', 'Navarro', 'Hernández'),
(22, 'Carmen Ramos', 'Ramos', 'González'),
(23, 'Héctor Díaz', 'Díaz', 'Sánchez'),
(24, 'Teresa Jiménez', 'Jiménez', 'Morales'),
(25, 'Santiago Ortiz', 'Ortiz', 'García'),
(26, 'Adriana Pérez', 'Pérez', 'Lopez'),
(27, 'Ricardo García', 'García', 'Ramírez'),
(28, 'Lorena González', 'González', 'Fernández'),
(29, 'Miguel Ángel García', 'García', 'Sánchez'),
(30, 'Juan Carlos Romero', 'Romero', 'Torres');
INSERT INTO users.position (name_position, description_position) VALUES
('Manager', 'Responsible for overseeing and coordinating the operations of a team or department.'),
('Sales Associate', 'Responsible for assisting customers and driving sales in retail or service settings.'),
('IT Specialist', 'Manages and maintains the company technology infrastructure and systems.'),
('HR Coordinator', 'Handles recruitment, employee relations, and company policies regarding human resources.'),
('Accountant', 'Responsible for managing financial records, budgets, and ensuring compliance with tax regulations.'),
('Marketing Director', 'Oversees and strategizes marketing campaigns and brand development.'),
('Product Manager', 'Leads product development efforts and coordinates between various departments to ensure product success.'),
('Customer Service Representative', 'Provides assistance to customers by addressing inquiries, complaints, and issues.'),
('Operations Director', 'Manages day-to-day operations of the company or a department to ensure efficiency.'),
('CEO', 'Chief Executive Officer, responsible for the overall strategic direction and success of the company.'),
('Chief Financial Officer (CFO)', 'Responsible for managing the company’s finances, financial planning, and risk management.'),
('Software Engineer', 'Designs, develops, and maintains software applications and systems.'),
('Project Manager', 'Oversees and ensures successful completion of projects by coordinating resources and teams.'),
('Legal Advisor', 'Provides legal advice and helps the company navigate legal issues and compliance matters.'),
('Administrative Assistant', 'Supports the administrative functions within the company, including scheduling and document management.');
INSERT INTO users.contract (id_employee, id_position, date_contract, type_contract, time_contrat) VALUES
(1, 1, '2025-01-15', 'Full-Time', 12),
(2, 2, '2025-02-01', 'Part-Time', 6),
(3, 3, '2025-03-01', 'Full-Time', 24),
(4, 4, '2025-03-15', 'Temporary', 6),
(5, 5, '2025-04-01', 'Internship', 3),
(6, 6, '2025-05-10', 'Full-Time', 12),
(7, 7, '2025-06-01', 'Part-Time', 18),
(8, 8, '2025-07-01', 'Full-Time', 36),
(9, 9, '2025-08-01', 'Temporary', 4),
(10, 10, '2025-09-01', 'Full-Time', 12),
(11, 11, '2025-10-01', 'Part-Time', 6),
(12, 12, '2025-11-01', 'Full-Time', 24),
(13, 13, '2025-12-01', 'Internship', 3),
(14, 14, '2025-12-15', 'Temporary', 12),
(15, 15, '2026-01-01', 'Full-Time', 18),
(16, 16, '2026-02-01', 'Part-Time', 9),
(17, 17, '2026-03-01', 'Full-Time', 24),
(18, 18, '2026-04-01', 'Temporary', 12),
(19, 19, '2026-05-01', 'Internship', 6),
(20, 20, '2026-06-01', 'Full-Time', 36),
(21, 21, '2026-07-01', 'Part-Time', 9),
(22, 22, '2026-08-01', 'Temporary', 12),
(23, 23, '2026-09-01', 'Full-Time', 12),
(24, 24, '2026-10-01', 'Internship', 6),
(25, 25, '2026-11-01', 'Full-Time', 24),
(26, 26, '2026-12-01', 'Part-Time', 12),
(27, 27, '2027-01-01', 'Full-Time', 18),
(28, 28, '2027-02-01', 'Temporary', 3),
(29, 29, '2027-03-01', 'Full-Time', 36),
(30, 30, '2027-04-01', 'Internship', 6);
INSERT INTO users.area (location_area, description_area, number_area) VALUES
('Building A', 'Sales and customer service department', 101),
('Building B', 'Research and development department', 102),
('Building C', 'Human resources department', 103),
('Building D', 'Accounting and finance department', 104),
('Building E', 'IT and technical support department', 105),
('Building F', 'Marketing and public relations department', 106),
('Building G', 'Legal department', 107),
('Building H', 'Executive and management offices', 108),
('Building I', 'Operations and logistics department', 109),
('Building J', 'Production and manufacturing department', 110),
('Building K', 'Warehouse and storage area', 111),
('Building L', 'Training and development center', 112),
('Building M', 'Employee lounge and recreation area', 113),
('Building N', 'Customer service center', 114),
('Building O', 'Conference and meeting rooms', 115),
('Building P', 'Security and surveillance department', 116),
('Building Q', 'Cleaning and maintenance department', 117),
('Building R', 'Purchasing and procurement department', 118),
('Building S', 'Product design and testing area', 119),
('Building T', 'Packaging and shipping area', 120);
INSERT INTO users.assing_area (id_employee, id_area) VALUES
(1, 1),  -- Employee 1 assigned to Area 1
(2, 2),  -- Employee 2 assigned to Area 2
(3, 3),  -- Employee 3 assigned to Area 3
(4, 4),  -- Employee 4 assigned to Area 4
(5, 5),  -- Employee 5 assigned to Area 5
(6, 6),  -- Employee 6 assigned to Area 6
(7, 7),  -- Employee 7 assigned to Area 7
(8, 8),  -- Employee 8 assigned to Area 8
(9, 9),  -- Employee 9 assigned to Area 9
(10, 10), -- Employee 10 assigned to Area 10
(11, 1),  -- Employee 11 assigned to Area 1
(12, 2),  -- Employee 12 assigned to Area 2
(13, 3),  -- Employee 13 assigned to Area 3
(14, 4),  -- Employee 14 assigned to Area 4
(15, 5),  -- Employee 15 assigned to Area 5
(16, 6),  -- Employee 16 assigned to Area 6
(17, 7),  -- Employee 17 assigned to Area 7
(18, 8),  -- Employee 18 assigned to Area 8
(19, 9),  -- Employee 19 assigned to Area 9
(20, 10);
INSERT INTO users.control_access (id_users, admin_control_access, buys_control_access, sale_control_access, store_control_access) VALUES
(1, 'Yes', 'Yes', 'Yes', 'No'),
(2, 'No', 'Yes', 'Yes', 'Yes'),
(3, 'Yes', 'No', 'Yes', 'No'),
(4, 'No', 'Yes', 'No', 'Yes'),
(5, 'Yes', 'Yes', 'Yes', 'Yes'),
(6, 'No', 'No', 'Yes', 'Yes'),
(7, 'Yes', 'No', 'No', 'Yes'),
(8, 'No', 'Yes', 'Yes', 'No'),
(9, 'Yes', 'Yes', 'No', 'No'),
(10, 'No', 'No', 'No', 'Yes'),
(11, 'Yes', 'Yes', 'No', 'Yes'),
(12, 'No', 'Yes', 'Yes', 'Yes'),
(13, 'Yes', 'No', 'Yes', 'Yes'),
(14, 'No', 'No', 'Yes', 'No'),
(15, 'Yes', 'Yes', 'Yes', 'Yes'),
(16, 'No', 'Yes', 'No', 'No'),
(17, 'Yes', 'No', 'Yes', 'No'),
(18, 'No', 'No', 'No', 'Yes'),
(19, 'Yes', 'Yes', 'No', 'No'),
(20, 'No', 'Yes', 'Yes', 'Yes');

--STORE--
INSERT INTO store.store (id_users, id_item, date_store, motion, amount_store, final_amount) VALUES
(1, 1, '2025-03-01', 'i', 100, 100),
(2, 2, '2025-03-02', 'i', 50, 50),
(3, 3, '2025-03-03', 's', 10, 40),
(4, 4, '2025-03-04', 'i', 200, 200),
(5, 5, '2025-03-05', 's', 20, 180),
(6, 6, '2025-03-06', 'i', 150, 150),
(7, 7, '2025-03-07', 's', 30, 120),
(8, 8, '2025-03-08', 'i', 75, 75),
(9, 9, '2025-03-09', 'i', 50, 50),
(10, 10, '2025-03-10', 's', 15, 35),
(11, 11, '2025-03-11', 'i', 100, 100),
(12, 12, '2025-03-12', 's', 40, 60),
(13, 13, '2025-03-13', 'i', 200, 200),
(14, 14, '2025-03-14', 's', 25, 175),
(15, 15, '2025-03-15', 'i', 100, 100),
(16, 16, '2025-03-16', 's', 60, 40),
(17, 17, '2025-03-17', 'i', 150, 150),
(18, 18, '2025-03-18', 's', 10, 140),
(19, 19, '2025-03-19', 'i', 50, 50),
(20, 20, '2025-03-20', 's', 30, 20),
(21, 21, '2025-03-21', 'i', 100, 100),
(22, 22, '2025-03-22', 's', 50, 50),
(23, 23, '2025-03-23', 'i', 75, 75),
(24, 24, '2025-03-24', 's', 40, 35),
(25, 25, '2025-03-25', 'i', 120, 120),
(26, 26, '2025-03-26', 's', 30, 90),
(27, 27, '2025-03-27', 'i', 80, 80),
(28, 28, '2025-03-28', 's', 20, 60),
(29, 29, '2025-03-29', 'i', 150, 150),
(30, 30, '2025-03-30', 's', 50, 100);
INSERT INTO store.item (name_item, description_item) VALUES
('Cargador de coche', 'Cargador de coche para dispositivos móviles, compatible con puertos USB-C y USB-A.'),
('Laptop gaming', 'Laptop gaming de alta gama con tarjeta gráfica NVIDIA, procesador Intel i9, 16 GB RAM y 1 TB SSD.'),
('Silla ergonómica', 'Silla ergonómica con soporte lumbar ajustable y reposabrazos, ideal para largas horas de trabajo.'),
('Power Bank solar', 'Power bank portátil con carga solar y capacidad de 20,000 mAh, para cargar dispositivos en exteriores.'),
('Smartphone 5G', 'Smartphone con tecnología 5G, pantalla OLED de 6.7 pulgadas y cámara triple de 64 MP.'),
('Teclado mecánico RGB', 'Teclado mecánico con retroiluminación RGB, ideal para gamers y programadores.'),
('Ratón gaming', 'Ratón gaming con sensor óptico de 16,000 DPI, botones programables y retroiluminación RGB.'),
('Monitor curvo 32"', 'Monitor curvo de 32 pulgadas, resolución 4K, ideal para trabajo creativo y videojuegos.'),
('Audífonos inalámbricos', 'Audífonos inalámbricos con cancelación de ruido activa y hasta 30 horas de autonomía.'),
('Cámara digital', 'Cámara digital compacta con lente de 20 MP y grabación en 4K, ideal para vloggers.'),
('Silla de oficina', 'Silla de oficina con ajuste de altura, respaldo reclinable y soporte lumbar ergonómico.'),
('Mousepad RGB', 'Mousepad grande con retroiluminación RGB, ideal para gaming y trabajo en escritorios amplios.'),
('Almacenamiento NAS', 'Dispositivo NAS de 4 bahías con 8 TB de capacidad total, ideal para almacenamiento en red doméstico.'),
('Impresora láser', 'Impresora láser monocromática con velocidad de impresión de hasta 30 páginas por minuto.'),
('Proyector portátil', 'Proyector portátil con resolución Full HD y conectividad inalámbrica para presentaciones y cine en casa.'),
('Smartwatch deportivo', 'Reloj inteligente con GPS, monitor de frecuencia cardíaca y resistencia al agua hasta 50 metros.'),
('Auriculares con micrófono', 'Auriculares con micrófono incorporado, ideales para videollamadas y conferencias.'),
('Cámara de seguridad IP', 'Cámara de seguridad IP con visión nocturna y grabación en alta definición.'),
('Router Wi-Fi mesh', 'Sistema de router Wi-Fi Mesh para cobertura sin interrupciones en toda la casa u oficina.'),
('Tablet 10"', 'Tablet de 10 pulgadas con pantalla de alta definición, procesador octa-core y 128 GB de almacenamiento.'),
('Cargador inalámbrico', 'Cargador inalámbrico rápido compatible con dispositivos Qi, hasta 15W de carga.'),
('Altavoces inteligentes', 'Altavoces inteligentes con integración a asistentes de voz, control de dispositivos IoT y sonido de alta calidad.'),
('Cargador portátil de 10,000 mAh', 'Cargador portátil compacto de 10,000 mAh con puerto USB-C y USB-A para carga rápida.'),
('Disco duro externo 1TB', 'Disco duro externo de 1TB con conexión USB 3.0 y formato resistente a golpes.'),
('Router 4G LTE', 'Router 4G LTE para conexión a internet móvil, ideal para viajes y lugares sin acceso a fibra óptica.'),
('Reloj de pared digital', 'Reloj de pared digital con display LED, ideal para oficinas y espacios de trabajo.'),
('Estuche para laptop', 'Estuche de neopreno resistente para laptops de hasta 15 pulgadas, con compartimentos adicionales.'),
('Gafas VR', 'Gafas de realidad virtual con pantalla de alta resolución y compatibilidad con dispositivos móviles.'),
('Bocina Bluetooth 360°', 'Bocina portátil Bluetooth con sonido 360 grados y batería de hasta 15 horas.'),
('Soporte para teléfono', 'Soporte ajustable para teléfono móvil, con ángulo de visión múltiple y base antideslizante.');

--BUYS--
INSERT INTO buys.buys (id_users, id_buys_detail, id_buys_supplier, date_buys) VALUES
(1, 1, 1, '2025-03-01'),
(2, 2, 2, '2025-03-02'),
(3, 3, 3, '2025-03-03'),
(4, 4, 4, '2025-03-04'),
(5, 5, 5, '2025-03-05'),
(6, 6, 6, '2025-03-06'),
(7, 7, 7, '2025-03-07'),
(8, 8, 8, '2025-03-08'),
(9, 9, 9, '2025-03-09'),
(10, 10, 10, '2025-03-10'),
(11, 11, 11, '2025-03-11'),
(12, 12, 12, '2025-03-12'),
(13, 13, 13, '2025-03-13'),
(14, 14, 14, '2025-03-14'),
(15, 15, 15, '2025-03-15'),
(16, 16, 16, '2025-03-16'),
(17, 17, 17, '2025-03-17'),
(18, 18, 18, '2025-03-18'),
(19, 19, 19, '2025-03-19'),
(20, 20, 20, '2025-03-20'),
(21, 21, 21, '2025-03-21'),
(22, 22, 22, '2025-03-22'),
(23, 23, 23, '2025-03-23'),
(24, 24, 24, '2025-03-24'),
(25, 25, 25, '2025-03-25'),
(26, 26, 26, '2025-03-26'),
(27, 27, 27, '2025-03-27'),
(28, 28, 28, '2025-03-28'),
(29, 29, 29, '2025-03-29'),
(30, 30, 30, '2025-03-30');

INSERT INTO buys.buys_detail (id_item, cost_detail, amount_detail) VALUES
(1, 450, 20),
(2, 650, 50),
(3, 250, 10),
(4, 1200, 30),
(5, 700, 15),
(6, 350, 40),
(7, 550, 12),
(8, 300, 25),
(9, 700, 18),
(10, 150, 35),
(11, 850, 20),
(12, 1000, 40),
(13, 400, 25),
(14, 300, 15),
(15, 550, 10),
(16, 900, 35),
(17, 450, 20),
(18, 600, 50),
(19, 400, 10),
(20, 650, 15),
(21, 600, 30),
(22, 500, 50),
(23, 900, 20),
(24, 1100, 8),
(25, 450, 25),
(26, 300, 18),
(27, 500, 12),
(28, 600, 15),
(29, 750, 40),
(30, 950, 5);
INSERT INTO buys.buys_supplier (supplier_name, company_name, email, number_phone) VALUES
('Juan Gómez', 'ElectroTech', 'juangomez@electrotech.com', '+34 600 123 456'),
('Ana Ruiz', 'SmartPhones S.A.', 'anar@smartphones.com', '+34 600 234 567'),
('Carlos López', 'Gaming Pro', 'carlos@gamingpro.com', '+34 600 345 678'),
('Sofía Sánchez', 'Comodity', 'sofia@comodity.com', '+34 600 456 789'),
('Pedro García', 'Tech World', 'pedro@techworld.com', '+34 600 567 890'),
('Marta Hernández', 'Power Solutions', 'marta@powersolutions.com', '+34 600 678 901'),
('Antonio Díaz', 'Digital Trends', 'antonio@digitaltrends.com', '+34 600 789 012'),
('Patricia López', 'Future Gadgets', 'patricia@futuregadgets.com', '+34 600 890 123'),
('David Morales', 'TechStore', 'david@techstore.com', '+34 600 901 234'),
('Raquel Martínez', 'Innova Electronics', 'raquel@innovaelectronics.com', '+34 600 012 345'),
('Manuel Pérez', 'NetGear', 'manuel@netgear.com', '+34 600 123 456'),
('Elena Castro', 'GigaTech', 'elena@gigatech.com', '+34 600 234 567'),
('Fernando Romero', 'Prime Electronics', 'fernando@primeelectronics.com', '+34 600 345 678'),
('Isabel Torres', 'HighTech Store', 'isabel@hightechstore.com', '+34 600 456 789'),
('Francisco Díaz', 'Smart Solutions', 'francisco@smartsolutions.com', '+34 600 567 890'),
('Beatriz López', 'ElectroMaster', 'beatriz@electromaster.com', '+34 600 678 901'),
('Javier Navarro', 'Gadget Pros', 'javier@gadgetpros.com', '+34 600 789 012'),
('Carmen Ramos', 'Techno Gear', 'carmen@technogear.com', '+34 600 890 123'),
('Héctor Díaz', 'Ultra Electronics', 'hector@ultraelectronics.com', '+34 600 901 234'),
('Teresa Jiménez', 'Mega Devices', 'teresa@megadevices.com', '+34 600 012 345'),
('Santiago Ortiz', 'NextGen Tech', 'santiago@nextgentech.com', '+34 600 123 456'),
('Adriana Pérez', 'VegaTech', 'adriana@vegatech.com', '+34 600 234 567'),
('Ricardo García', 'Innovative Solutions', 'ricardo@innovativesolutions.com', '+34 600 345 678'),
('Lorena González', 'Global Electronics', 'lorena@globalelectronics.com', '+34 600 456 789'),
('Miguel Ángel García', 'TechFix', 'miguel@techfix.com', '+34 600 567 890'),
('Juan Carlos Romero', 'Perfect Electronics', 'juancarlos@perfectelectronics.com', '+34 600 678 901'),
('Verónica Sánchez', 'Smart Devices', 'veronica@smartdevices.com', '+34 600 789 012'),
('Ricardo Torres', 'NextLevel Electronics', 'ricardo@nextlevelelectronics.com', '+34 600 890 123'),
('Luis Rodríguez', 'Quantum Solutions', 'luis@quantumsolutions.com', '+34 600 901 234'),
('Mónica Díaz', 'Top Gear', 'monica@topgear.com', '+34 600 012 345');

--PROMOTION--
INSERT INTO promotion.promotion (id_item, date_promotion, amount_promotion, discount) VALUES
(1, '2025-03-01', 50, 10),  -- Promoción en el artículo 1, 50 unidades a un 10% de descuento
(2, '2025-03-10', 30, 15),  -- Promoción en el artículo 2, 30 unidades a un 15% de descuento
(3, '2025-03-15', 20, 20),  -- Promoción en el artículo 3, 20 unidades a un 20% de descuento
(4, '2025-04-01', 100, 5),  -- Promoción en el artículo 4, 100 unidades a un 5% de descuento
(5, '2025-04-10', 150, 25), -- Promoción en el artículo 5, 150 unidades a un 25% de descuento
(6, '2025-05-01', 200, 30), -- Promoción en el artículo 6, 200 unidades a un 30% de descuento
(7, '2025-05-10', 10, 50),  -- Promoción en el artículo 7, 10 unidades a un 50% de descuento
(8, '2025-06-01', 80, 15),  -- Promoción en el artículo 8, 80 unidades a un 15% de descuento
(9, '2025-06-10', 60, 10),  -- Promoción en el artículo 9, 60 unidades a un 10% de descuento
(10, '2025-06-15', 120, 20); -- Promoción en el artículo 10, 120 unidades a un 20% de descuento
--1.-¿Que promociones ha tenido un producto x ?
SELECT p.id, p.date_promotion, p.amount_promotion, p.discount
FROM promotion.promotion p
JOIN store.item i ON p.id_item = i.id
WHERE i.id = <id_producto_x>;

--2.- mostrar  las ventas realizadas por un usuario x
SELECT s.id, s.date_sale, sd.amount, sd.cost_detail
FROM sale.sale s
JOIN sale.sale_detail sd ON s.id_detail = sd.id
WHERE s.id_users = <id_usuario_x>;

--3.- mostrar la lista de empleados en un cargo x 
SELECT e.id, e.name_employee, e.ap_paterno, e.ap_materno
FROM users.employee e
JOIN users.contract c ON e.id = c.id_employee
JOIN users.position p ON c.id_position = p.id
WHERE p.id = <id_cargo_x>;

--4.-mostar una lista de empleados que alla realizado una compra y saber el cargo 
SELECT e.id, e.name_employee, e.ap_paterno, e.ap_materno, p.name_position
FROM users.employee e
JOIN users.contract c ON e.id = c.id_employee
JOIN users.position p ON c.id_position = p.id
JOIN sale.sale s ON s.id_users = e.id
WHERE s.id_detail IS NOT NULL;

--5.- saber cuanto queda de un producto x 
SELECT i.name_item, (s.amount_store - s.final_amount) AS remaining_stock
FROM store.store s
JOIN store.item i ON s.id_item = i.id
WHERE i.id = <id_producto_x>
ORDER BY s.date_store DESC
LIMIT 1;

--6.- mostrar la lista de proveedores que venden un producto x 
SELECT DISTINCT bs.supplier_name, bs.company_name, bs.email
FROM buys.buys b
JOIN buys.buys_supplier bs ON b.id_buys_supplier = bs.id
JOIN buys.buys_detail bd ON b.id_buys_detail = bd.id
WHERE bd.id_item = <id_producto_x>;

--7.- saber cuanto hacido el ingreso por ventas realizadas por un mes x 
SELECT SUM(sd.amount * sd.cost_detail) AS total_income
FROM sale.sale s
JOIN sale.sale_detail sd ON s.id_detail = sd.id
WHERE EXTRACT(MONTH FROM s.date_sale) = <mes_x>
AND EXTRACT(YEAR FROM s.date_sale) = <año_x>;

--8.-conocer el producto mas vendido 
SELECT i.name_item, SUM(sd.amount) AS total_sold
FROM sale.sale_detail sd
JOIN store.item i ON sd.id_item = i.id
GROUP BY i.id
ORDER BY total_sold DESC
LIMIT 1;

--9.- conocer al cliente que más productos ha comprado 
SELECT c.name_client, SUM(sd.amount) AS total_purchased
FROM sale.sale s
JOIN sale.sale_detail sd ON s.id_detail = sd.id
JOIN sale.client c ON s.id_client = c.id
GROUP BY c.id
ORDER BY total_purchased DESC
LIMIT 1;

--10.-Conocer al cliente  con el costo más alto de compra 
SELECT c.name_client, SUM(sd.amount * sd.cost_detail) AS total_spent
FROM sale.sale s
JOIN sale.sale_detail sd ON s.id_detail = sd.id
JOIN sale.client c ON s.id_client = c.id
GROUP BY c.id
ORDER BY total_spent DESC
LIMIT 1;

--11.-mostrar la cantidad de clientes que se tiene 
SELECT COUNT(*) AS total_clients
FROM sale.client;

--12.-mostrar los productos con un stock menor a 10
SELECT i.name_item, (s.amount_store - s.final_amount) AS remaining_stock
FROM store.store s
JOIN store.item i ON s.id_item = i.id
GROUP BY i.id
HAVING (s.amount_store - s.final_amount) < 10;

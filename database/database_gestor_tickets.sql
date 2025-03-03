--
-- Base de datos: `gestor_tickets`
--
CREATE DATABASE IF NOT EXISTS `gestor_tickets` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `gestor_tickets`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20250301210638', '2025-03-01 22:06:46', 45),
('DoctrineMigrations\\Version20250301214711', '2025-03-01 22:47:19', 234);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `message`
--

CREATE TABLE `message` (
  `id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `text` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `message`
--

INSERT INTO `message` (`id`, `author_id`, `ticket_id`, `text`) VALUES
(1, 5, 2, 'Mañana te mando a un técnico'),
(2, 4, 2, 'Ya ha venido y lo ha arreglado. Muchas gracias'),
(3, 3, 6, 'Pulsa el botón de apagado durante 10 segundos por si se quedó pillado. Luego pulsa de nuevo como siempre'),
(4, 3, 6, '¿Te ha funcionado?'),
(5, 2, 6, 'Sí, aunque cambiaré la batería del portátil también por una nueva'),
(6, 2, 6, '¿Vendéis baterías?'),
(7, 3, 6, 'Sí, en nuestra tienda online. Un placer ayudar'),
(8, 5, 5, '¿Seguro que estás escribiendo bien las fórmulas?'),
(9, 2, 5, 'Echaré un vistazo y te cuento qué tal...'),
(10, 5, 5, '¡Perfecto! Aquí espero tu respuesta'),
(11, 3, 4, 'No te preocupes. Te enviaremos uno nuevo'),
(12, 4, 4, 'De acuerdo, gracias');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ticket`
--

CREATE TABLE `ticket` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `worker_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `text` varchar(255) NOT NULL,
  `state` varchar(255) DEFAULT NULL,
  `score` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ticket`
--

INSERT INTO `ticket` (`id`, `client_id`, `worker_id`, `title`, `text`, `state`, `score`) VALUES
(1, 2, NULL, 'Problema al iniciar sesión', 'No puedo acceder a mi cuenta. Recibo un error al intentar iniciar sesión', NULL, NULL),
(2, 4, 5, 'Falla Microsoft Word', 'Tengo el paquete office original, estoy registrado y aun así tiene algunos glitch', 'finalizado', 5),
(3, 4, NULL, 'Problemas con el wifi', 'Contraté hace unos meses con una nueva compañía telefónica. Iba bien pero la velocidad ahora es demasiado lenta', NULL, NULL),
(4, 4, 3, 'Tóner de tinta seco', 'Compre un tóner por vuestra tienda online y me llegó seco. Quiero uno nuevo o la devolución', 'finalizado', NULL),
(5, 2, 5, 'No va el Excel', 'Necesito usar con frecuencia este programa por mi trabajo, pero no hace bien los cálculos y hace cosas raras', 'abierto', NULL),
(6, 2, 3, 'No enciende el pc', 'Estoy usando el ordenador de mi hermana porque mi ordenador no hay manera de que se encienda', 'finalizado', 3),
(7, 6, NULL, 'He perdido mi BBDD', 'Tenía guardada mi colección de libros y se han borrado. ¿Cómo puedo recuperarla?', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(180) NOT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`roles`)),
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `username`, `roles`, `password`) VALUES
(1, 'admin', '[\"ROLE_USER\", \"ROLE_ADMIN\"]', '$2y$13$vfVQ9t3RLP97L4QVC7Ubi.sTpiwJbVaBiZst7kSD3hhrI4Qv.05gC'),
(2, 'jorge', '[\"ROLE_USER\"]', '$2y$13$s./DyjSIhGYe/280cq/sF.eEVzfvvcke3VPNKay0nPBFMA55c8ugG'),
(3, 'laura', '[\"ROLE_USER\", \"ROLE_WORKER\"]', '$2y$13$p2RE6u.VyQ/YaKzoZm4yxeJ/uy.D.eRza8xVgSCU7uQp2b9LcAVEm'),
(4, 'juan', '[\"ROLE_USER\"]', '$2y$13$YnS91onHlNT47aw1pwl2Tu6lIfNUJPpSZ.Ll3aT6jpcGalvTJz/3C'),
(5, 'lola', '[\"ROLE_WORKER\"]', '$2y$13$8srkEfI5e.mfHvDSyfofJeEYETV8xJS9q2uCilqD3LvNpQDuO1ul.'),
(6, 'dario', '[\"ROLE_USER\"]', '$2y$13$Jp7CYWQSrTOIha5W8CeJKus5zZh4xS8.zxagAKgNGrmAOS5nGJsqK');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indices de la tabla `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_B6BD307FF675F31B` (`author_id`),
  ADD KEY `IDX_B6BD307F700047D2` (`ticket_id`);

--
-- Indices de la tabla `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Indices de la tabla `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_97A0ADA319EB6921` (`client_id`),
  ADD KEY `IDX_97A0ADA36B20BA36` (`worker_id`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_IDENTIFIER_USERNAME` (`username`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `message`
--
ALTER TABLE `message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ticket`
--
ALTER TABLE `ticket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `FK_B6BD307F700047D2` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`),
  ADD CONSTRAINT `FK_B6BD307FF675F31B` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`);

--
-- Filtros para la tabla `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `FK_97A0ADA319EB6921` FOREIGN KEY (`client_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `FK_97A0ADA36B20BA36` FOREIGN KEY (`worker_id`) REFERENCES `user` (`id`);

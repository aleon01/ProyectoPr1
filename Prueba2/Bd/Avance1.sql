toc.dat                                                                                             0000600 0004000 0002000 00000162106 13547124767 0014465 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP       "        
        	    w            proyectopr1    11.5    11.5 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false         �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false         �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false         �           1262    17058    proyectopr1    DATABASE     �   CREATE DATABASE proyectopr1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Spain.1252' LC_CTYPE = 'Spanish_Spain.1252';
    DROP DATABASE proyectopr1;
             postgres    false                     2615    17059 	   proyecto1    SCHEMA        CREATE SCHEMA proyecto1;
    DROP SCHEMA proyecto1;
             postgres    false                     2615    25252    security    SCHEMA        CREATE SCHEMA security;
    DROP SCHEMA security;
             postgres    false         �           0    0    SCHEMA security    COMMENT     Z   COMMENT ON SCHEMA security IS 'Schema que se encarga de almacenar el tema de seguridad.';
                  postgres    false    8         
            2615    25294 	   servicios    SCHEMA        CREATE SCHEMA servicios;
    DROP SCHEMA servicios;
             postgres    false                     2615    17572    usuarios    SCHEMA        CREATE SCHEMA usuarios;
    DROP SCHEMA usuarios;
             postgres    false         �            1255    17573    f_cerrar_sesion(text)    FUNCTION     �   CREATE FUNCTION proyecto1.f_cerrar_sesion(_sesion text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	
	BEGIN
		UPDATE
			proyecto1.autenticacion
		SET
			fecha_fin = current_timestamp
		WHERE
			sesion = _sesion;			
	END
	
$$;
 7   DROP FUNCTION proyecto1.f_cerrar_sesion(_sesion text);
    	   proyecto1       postgres    false    11         �            1255    17574 F   f_guardado_sesion(integer, character varying, character varying, text)    FUNCTION     y  CREATE FUNCTION proyecto1.f_guardado_sesion(_user_id integer, _ip character varying, _mac character varying, _sesion text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	
	BEGIN
		INSERT INTO proyecto1.autenticacion
		(
			user_id,
			ip,
			mac,
			fecha_inicio,
			sesion
		)
	VALUES 
		(
			_user_id,
			_ip,
			_mac,
			current_timestamp,
			_sesion
		);	
		
	END

$$;
 z   DROP FUNCTION proyecto1.f_guardado_sesion(_user_id integer, _ip character varying, _mac character varying, _sesion text);
    	   proyecto1       postgres    false    11         �            1255    17236 (   f_insertar_servicio(text, integer, text)    FUNCTION       CREATE FUNCTION proyecto1.f_insertar_servicio(_nom_ser text, _costo integer, _tiempo text) RETURNS SETOF boolean
    LANGUAGE plpgsql
    AS $$
	DECLARE
		_cantidad integer;
	BEGIN
		_cantidad := (SELECT COUNT(*) FROM proyecto1.servicio WHERE nom_ser = _nom_ser);

		IF _cantidad = 0
		THEN
			INSERT INTO 
			proyecto1.servicio
			(
				nom_ser, 
				costo,
				tiempo
			)
			VALUES
			(
			_nom_ser,
			_costo,
			_tiempo
			);

			RETURN QUERY SELECT TRUE;
			ELSE
			RETURN QUERY SELECT FALSE;
			END IF;
		END;
		$$;
 Z   DROP FUNCTION proyecto1.f_insertar_servicio(_nom_ser text, _costo integer, _tiempo text);
    	   proyecto1       postgres    false    11         �            1255    17575 4   f_insertar_usuarios(text, text, text, integer, text)    FUNCTION     q  CREATE FUNCTION proyecto1.f_insertar_usuarios(_user_name text, _clave text, _nombre text, _cedula integer, _correo text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	begin
		
		INSERT INTO proyecto1.usuario
		(
			user_name,
			clave,
			nombre,
			cedula,
			correo
		)
		VALUES 
		(
			_user_name,
			_clave,
			_nombre,
			_cedula,
			_correo	
		);

	end

$$;
 x   DROP FUNCTION proyecto1.f_insertar_usuarios(_user_name text, _clave text, _nombre text, _cedula integer, _correo text);
    	   proyecto1       postgres    false    11         �            1259    17229    v_login    VIEW     |   CREATE VIEW proyecto1.v_login AS
 SELECT 0 AS user_id,
    ''::text AS nombre,
    0 AS rol_id,
    ''::text AS rol_nombre;
    DROP VIEW proyecto1.v_login;
    	   proyecto1       postgres    false    11         �            1255    17234    f_login(text, text)    FUNCTION     �  CREATE FUNCTION proyecto1.f_login(_usuario text, _clave text) RETURNS SETOF proyecto1.v_login
    LANGUAGE plpgsql
    AS $$
		BEGIN
			RETURN QUERY
			SELECT
				uu.id_usuario AS user_id,
				uu.nombre AS nombre,
				ur.id_rol AS rol_id,
				ur.nom_rol AS rol_nombre

			FROM
				proyecto1.usuarios uu JOIN proyecto1.rol ur ON ur.id_rol = uu.rol_id
			WHERE
				uu.usuario = _usuario
			AND
				uu.clave = _clave;
		END;
	$$;
 =   DROP FUNCTION proyecto1.f_login(_usuario text, _clave text);
    	   proyecto1       postgres    false    11    214         �            1255    25253    f_cerrar_session(text)    FUNCTION     �   CREATE FUNCTION security.f_cerrar_session(_session text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	
	BEGIN
		UPDATE
			security.autenication
		SET
			fecha_fin = current_timestamp
		WHERE
			session = _session;
			
	END

$$;
 8   DROP FUNCTION security.f_cerrar_session(_session text);
       security       postgres    false    8         �            1255    25254 G   f_guardado_session(integer, character varying, character varying, text)    FUNCTION     �  CREATE FUNCTION security.f_guardado_session(_user_id integer, _ip character varying, _mac character varying, _session text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	
	BEGIN
		INSERT INTO security.autenication
		(
			user_id,
			ip,
			mac,
			fecha_inicio,
			session
		)
	VALUES 
		(
			_user_id,
			_ip,
			_mac,
			current_timestamp,
			_session
		);


		
		
	END

$$;
 {   DROP FUNCTION security.f_guardado_session(_user_id integer, _ip character varying, _mac character varying, _session text);
       security       postgres    false    8         �            1255    25255    f_log_auditoria()    FUNCTION     �  CREATE FUNCTION security.f_log_auditoria() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	 DECLARE
		_pk TEXT :='';		-- Representa la llave primaria de la tabla que esta siedno modificada.
		_sql TEXT;		-- Variable para la creacion del procedured.
		_column_guia RECORD; 	-- Variable para el FOR guarda los nombre de las columnas.
		_column_key RECORD; 	-- Variable para el FOR guarda los PK de las columnas.
		_session TEXT;	-- Almacena el usuario que genera el cambio.
		_user_db TEXT;		-- Almacena el usuario de bd que genera la transaccion.
		_control INT;		-- Variabel de control par alas llaves primarias.
		_count_key INT = 0;	-- Cantidad de columnas pertenecientes al PK.
		_sql_insert TEXT;	-- Variable para la construcción del insert del json de forma dinamica.
		_sql_delete TEXT;	-- Variable para la construcción del delete del json de forma dinamica.
		_sql_update TEXT;	-- Variable para la construcción del update del json de forma dinamica.
		_new_data RECORD; 	-- Fila que representa los campos nuevos del registro.
		_old_data RECORD;	-- Fila que representa los campos viejos del registro.

	BEGIN

			-- Se genera la evaluacion para determianr el tipo de accion sobre la tabla
		 IF (TG_OP = 'INSERT') THEN
			_new_data := NEW;
			_old_data := NEW;
		ELSEIF (TG_OP = 'UPDATE') THEN
			_new_data := NEW;
			_old_data := OLD;
		ELSE
			_new_data := OLD;
			_old_data := OLD;
		END IF;

		-- Se genera la evaluacion para determianr el tipo de accion sobre la tabla
		IF ((SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = TG_TABLE_SCHEMA AND table_name = TG_TABLE_NAME AND column_name = 'id' ) > 0) THEN
			_pk := _new_data.id;
		ELSE
			_pk := '-1';
		END IF;

		-- Se valida que exista el campo modified_by
		IF ((SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = TG_TABLE_SCHEMA AND table_name = TG_TABLE_NAME AND column_name = 'session') > 0) THEN
			_session := _new_data.session;
		ELSE
			_session := '';
		END IF;

		-- Se guarda el susuario de bd que genera la transaccion
		_user_db := (SELECT CURRENT_USER);

		-- Se evalua que exista el procedimeinto adecuado
		IF (SELECT COUNT(*) FROM security.function_db_view acfdv WHERE acfdv.b_function = 'field_audit' AND acfdv.b_type_parameters = TG_TABLE_SCHEMA || '.'|| TG_TABLE_NAME || ', '|| TG_TABLE_SCHEMA || '.'|| TG_TABLE_NAME || ', character varying, character varying, character varying, text, character varying, text, text') > 0
			THEN
				-- Se realiza la invocación del procedured generado dinamivamente
				PERFORM security.field_audit(_new_data, _old_data, TG_OP, _session, _user_db , _pk, ''::text);
		ELSE
			-- Se empieza la construcción del Procedured generico
			_sql := 'CREATE OR REPLACE FUNCTION security.field_audit( _data_new '|| TG_TABLE_SCHEMA || '.'|| TG_TABLE_NAME || ', _data_old '|| TG_TABLE_SCHEMA || '.'|| TG_TABLE_NAME || ', _accion character varying, _session text, _user_db character varying, _table_pk text, _init text)'
			|| ' RETURNS TEXT AS ''
'
			|| '
'
	|| '	DECLARE
'
	|| '		_column_data TEXT;
	 	_datos jsonb;
	 	
'
	|| '	BEGIN
			_datos = ''''{}'''';
';
			-- Se evalua si hay que actualizar la pk del registro de auditoria.
			IF _pk = '-1'
				THEN
					_sql := _sql
					|| '
		_column_data := ';

					-- Se genera el update con la clave pk de la tabla
					SELECT
						COUNT(isk.column_name)
					INTO
						_control
					FROM
						information_schema.table_constraints istc JOIN information_schema.key_column_usage isk ON isk.constraint_name = istc.constraint_name
					WHERE
						istc.table_schema = TG_TABLE_SCHEMA
					 AND	istc.table_name = TG_TABLE_NAME
					 AND	istc.constraint_type ilike '%primary%';

					-- Se agregan las columnas que componen la pk de la tabla.
					FOR _column_key IN SELECT
							isk.column_name
						FROM
							information_schema.table_constraints istc JOIN information_schema.key_column_usage isk ON isk.constraint_name = istc.constraint_name
						WHERE
							istc.table_schema = TG_TABLE_SCHEMA
						 AND	istc.table_name = TG_TABLE_NAME
						 AND	istc.constraint_type ilike '%primary%'
						ORDER BY 
							isk.ordinal_position  LOOP

						_sql := _sql || ' _data_new.' || _column_key.column_name;
						
						_count_key := _count_key + 1 ;
						
						IF _count_key < _control THEN
							_sql :=	_sql || ' || ' || ''''',''''' || ' ||';
						END IF;
					END LOOP;
				_sql := _sql || ';';
			END IF;

			_sql_insert:='
		IF _accion = ''''INSERT''''
			THEN
				';
			_sql_delete:='
		ELSEIF _accion = ''''DELETE''''
			THEN
				';
			_sql_update:='
		ELSE
			';

			-- Se genera el ciclo de agregado de columnas para el nuevo procedured
			FOR _column_guia IN SELECT column_name, data_type FROM information_schema.columns WHERE table_schema = TG_TABLE_SCHEMA AND table_name = TG_TABLE_NAME
				LOOP
						
					_sql_insert:= _sql_insert || '_datos := _datos || json_build_object('''''
					|| _column_guia.column_name
					|| '_nuevo'
					|| ''''', '
					|| '_data_new.'
					|| _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea', 'USER-DEFINED') THEN 
						_sql_insert:= _sql_insert
						||'::text';
					END IF;

					_sql_insert:= _sql_insert || ')::jsonb;
				';

					_sql_delete := _sql_delete || '_datos := _datos || json_build_object('''''
					|| _column_guia.column_name
					|| '_anterior'
					|| ''''', '
					|| '_data_old.'
					|| _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea', 'USER-DEFINED') THEN 
						_sql_delete:= _sql_delete
						||'::text';
					END IF;

					_sql_delete:= _sql_delete || ')::jsonb;
				';

					_sql_update := _sql_update || 'IF _data_old.' || _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea','USER-DEFINED') THEN 
						_sql_update:= _sql_update
						||'::text';
					END IF;

					_sql_update:= _sql_update || ' <> _data_new.' || _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea','USER-DEFINED') THEN 
						_sql_update:= _sql_update
						||'::text';
					END IF;

					_sql_update:= _sql_update || '
				THEN _datos := _datos || json_build_object('''''
					|| _column_guia.column_name
					|| '_anterior'
					|| ''''', '
					|| '_data_old.'
					|| _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea','USER-DEFINED') THEN 
						_sql_update:= _sql_update
						||'::text';
					END IF;

					_sql_update:= _sql_update
					|| ', '''''
					|| _column_guia.column_name
					|| '_nuevo'
					|| ''''', _data_new.'
					|| _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea', 'USER-DEFINED') THEN 
						_sql_update:= _sql_update
						||'::text';
					END IF;

					_sql_update:= _sql_update
					|| ')::jsonb;
			END IF;
			';
			END LOOP;

			-- Se le agrega la parte final del procedured generico
			
			_sql:= _sql || _sql_insert || _sql_delete || _sql_update
			|| ' 
		END IF;

		INSERT INTO security.auditoria
		(
			fecha,
			accion,
			schema,
			tabla,
			pk,
			session,
			user_bd,
			data
		)
		VALUES
		(
			CURRENT_TIMESTAMP,
			_accion,
			''''' || TG_TABLE_SCHEMA || ''''',
			''''' || TG_TABLE_NAME || ''''',
			_table_pk,
			_session,
			_user_db,
			_datos::jsonb
			);

		RETURN NULL; 
	END;'''
|| '
LANGUAGE plpgsql;';

			-- Se genera la ejecución de _sql, es decir se crea el nuevo procedured de forma generica.
			EXECUTE _sql;

		-- Se realiza la invocación del procedured generado dinamivamente
			PERFORM security.field_audit(_new_data, _old_data, TG_OP::character varying, _session, _user_db, _pk, ''::text);

		END IF;

		RETURN NULL;

END;
$$;
 *   DROP FUNCTION security.f_log_auditoria();
       security       postgres    false    8         �            1259    25257    autenticate_view    VIEW     �   CREATE VIEW security.autenticate_view AS
 SELECT 0 AS user_id,
    ''::character varying(100) AS nombre,
    0 AS rol_id,
    ''::text AS rol_name;
 %   DROP VIEW security.autenticate_view;
       security       postgres    false    8                    1255    25290    f_loggin(text, text)    FUNCTION     x  CREATE FUNCTION security.f_loggin(_usuario text, _clave text) RETURNS SETOF security.autenticate_view
    LANGUAGE plpgsql
    AS $$
	DECLARE
		_user_id INTEGER;
		_nombre CHARACTER VARYING(100);
		_rol_id integer;
		_rol_nombre text;

	BEGIN

		IF (SELECT COUNT(*) FROM usuarios.usuarios WHERE usuario = _usuario AND clave = _clave ) > 0
			THEN
				SELECT
					uu.id_usuario,
					uu.nombre,
					ur.id_rol,
					ur.nombre_rol
				INTO
					_user_id,
					_nombre,
					_rol_id,
					_rol_nombre
				FROM
					usuarios.usuarios uu JOIN usuarios.roles ur ON ur.id_rol = uu.rol_id
				WHERE
					uu.usuario = _usuario AND uu.clave = _clave;
				 				
				RETURN QUERY 
					SELECT
						_user_id,
						_nombre,
						_rol_id,
						_rol_nombre;
		ELSE
			RETURN QUERY
				SELECT
					-1::INTEGER,
					''::CHARACTER VARYING(100),
					-1:: INTEGER,
					''::TEXT;
		END IF;
		
	END

$$;
 =   DROP FUNCTION security.f_loggin(_usuario text, _clave text);
       security       postgres    false    8    220                    1255    25315 3   f_actualizar_servicio(integer, text, integer, text)    FUNCTION     =  CREATE FUNCTION servicios.f_actualizar_servicio(_id_ser integer, _nom_ser text, _costo integer, _tiempo text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
BEGIN

	UPDATE
		servicios.servicio
	SET
		id_ser = _id_ser,
		nom_ser = _nom_ser,
		costo = _costo,
		tiempo = _tiempo

	WHERE
		id_ser = _id_ser;

END
$$;
 m   DROP FUNCTION servicios.f_actualizar_servicio(_id_ser integer, _nom_ser text, _costo integer, _tiempo text);
    	   servicios       postgres    false    10         �            1255    25314    f_eliminar_servicio(integer)    FUNCTION     �   CREATE FUNCTION servicios.f_eliminar_servicio(_id_ser integer) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
BEGIN
	DELETE FROM servicios.servicio WHERE id_ser = _id_ser;
END
$$;
 >   DROP FUNCTION servicios.f_eliminar_servicio(_id_ser integer);
    	   servicios       postgres    false    10                    1255    25409 4   f_insertar_servicio(text, integer, text, text, text)    FUNCTION     q  CREATE FUNCTION servicios.f_insertar_servicio(_nom_ser text, _costo integer, _tiempo text, _f_servicio text, _descripcion text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
BEGIN

	INSERT INTO servicios.servicio
	(
		nom_ser,
		costo,
		tiempo,
		f_servicio,
		descripcion
	)
	VALUES 
	(
		_nom_ser,
		_costo,
		_tiempo,
		_f_servicio,
		_descripcion
	);

END
$$;
    DROP FUNCTION servicios.f_insertar_servicio(_nom_ser text, _costo integer, _tiempo text, _f_servicio text, _descripcion text);
    	   servicios       postgres    false    10                    1255    25407     f_insertar_serviciof(text, text)    FUNCTION     �   CREATE FUNCTION servicios.f_insertar_serviciof(_nom_ser text, _f_servicio text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
BEGIN

	INSERT INTO servicios.prueba
	(
		nom_ser,
		f_servicio
	)
	VALUES 
	(
		_nom_ser,
		_f_servicio
	);

END
$$;
 O   DROP FUNCTION servicios.f_insertar_serviciof(_nom_ser text, _f_servicio text);
    	   servicios       postgres    false    10         �            1259    25306    v_servicios    VIEW     �   CREATE VIEW servicios.v_servicios WITH (security_barrier='false') AS
 SELECT 0 AS servicio_id,
    ''::text AS servicio_nom,
    0 AS costo,
    ''::text AS tiempo,
    ''::text AS servicio_f,
    ''::text AS servicio_des;
 !   DROP VIEW servicios.v_servicios;
    	   servicios       postgres    false    10                     1255    25316    f_obtener_asignars()    FUNCTION     �   CREATE FUNCTION servicios.f_obtener_asignars() RETURNS SETOF servicios.v_servicios
    LANGUAGE plpgsql
    AS $$
BEGIN

		RETURN QUERY
		SELECT nom_ser
		FROM
			servicios.servicio;
END
$$;
 .   DROP FUNCTION servicios.f_obtener_asignars();
    	   servicios       postgres    false    10    228         �            1259    25390    v_fotoss    VIEW     p   CREATE VIEW servicios.v_fotoss AS
 SELECT 0 AS servicio_id,
    ''::text AS servicio_nom,
    ''::text AS foto;
    DROP VIEW servicios.v_fotoss;
    	   servicios       postgres    false    10                    1255    25408    f_obtener_fotos()    FUNCTION     A  CREATE FUNCTION servicios.f_obtener_fotos() RETURNS SETOF servicios.v_fotoss
    LANGUAGE plpgsql
    AS $$

		begin
        		return query 
                	select 
                    	cc.nom_ser,
                        cc.f_servicio
                     from 
                     	servicios.prueba;
        end 
$$;
 +   DROP FUNCTION servicios.f_obtener_fotos();
    	   servicios       postgres    false    229    10         �            1255    25312    f_obtener_servicio()    FUNCTION     �   CREATE FUNCTION servicios.f_obtener_servicio() RETURNS SETOF servicios.v_servicios
    LANGUAGE plpgsql
    AS $$
BEGIN

		RETURN QUERY
		SELECT *
		FROM
			servicios.servicio;
END
$$;
 .   DROP FUNCTION servicios.f_obtener_servicio();
    	   servicios       postgres    false    10    228                    1255    25233 O   f_insertar_usuarios(text, text, integer, text, text, text, integer, text, text)    FUNCTION     �  CREATE FUNCTION usuarios.f_insertar_usuarios(_nombre text, _apellido text, _numero_identificacion integer, _correo text, _usuario text, _clave text, _rol_id integer, _session text, _tipo_identificacion text) RETURNS SETOF boolean
    LANGUAGE plpgsql
    AS $$
	BEGIN
		
		IF
			(SELECT COUNT (*) FROM usuarios.usuarios 
			WHERE (usuario = _usuario )) = 0
			THEN
				INSERT INTO usuarios.usuarios(
					--columnas de las tablas
				nombre,
				apellido,				
				numero_identificacion,
				correo,
				usuario,
				clave,
				rol_id,
				session,
				tipo_identificacion,
				create_date
				)
				VALUES 
				(
					--datos de entrada de visual
				_nombre,
				_apellido,					
				_numero_identificacion,
				_correo,
				_usuario,
				_clave,
				_rol_id,
				_session,				
				_tipo_identificacion,
				current_timestamp
				);
				
				RETURN QUERY
				SELECT true;
				
		ELSE
				RETURN QUERY
				SELECT false;
		END IF;
END
$$;
 �   DROP FUNCTION usuarios.f_insertar_usuarios(_nombre text, _apellido text, _numero_identificacion integer, _correo text, _usuario text, _clave text, _rol_id integer, _session text, _tipo_identificacion text);
       usuarios       postgres    false    6         �            1259    17611    v_login    VIEW     ~   CREATE VIEW usuarios.v_login AS
 SELECT 0 AS id_usuario,
    ''::text AS nombre,
    0 AS rol_id,
    ''::text AS rol_nombre;
    DROP VIEW usuarios.v_login;
       usuarios       postgres    false    6         �            1255    17616    f_login(text, text)    FUNCTION     �  CREATE FUNCTION usuarios.f_login(_usuario text, _clave text) RETURNS SETOF usuarios.v_login
    LANGUAGE plpgsql
    AS $$
		BEGIN
			RETURN QUERY
			SELECT
				uu.id_usuario AS id_usuario,
				uu.nombre AS nombre,
				ur.id_rol AS rol_id,
				ur.nombre_rol AS rol_nombre

			FROM
				usuarios.usuarios uu JOIN usuarios.roles ur ON ur.id_rol = uu.rol_id
			WHERE
				uu.usuario = _usuario
			AND
				uu.clave = _clave;
		END;
	$$;
 <   DROP FUNCTION usuarios.f_login(_usuario text, _clave text);
       usuarios       postgres    false    219    6         �            1259    17580    usuarios    TABLE     w  CREATE TABLE usuarios.usuarios (
    id_usuario integer NOT NULL,
    nombre text NOT NULL,
    apellido text NOT NULL,
    numero_identificacion integer NOT NULL,
    correo text NOT NULL,
    usuario text NOT NULL,
    clave text NOT NULL,
    rol_id integer NOT NULL,
    session text,
    tipo_identificacion text NOT NULL,
    create_date timestamp without time zone
);
    DROP TABLE usuarios.usuarios;
       usuarios         postgres    false    6         �            1255    25223    f_obtener_usuarios(text)    FUNCTION     �   CREATE FUNCTION usuarios.f_obtener_usuarios(_filtro text) RETURNS SETOF usuarios.usuarios
    LANGUAGE plpgsql
    AS $$
	
	BEGIN
		RETURN QUERY
			SELECT
				*
			FROM
				usuarios.usuarios
			WHERE
				nombre ilike '%' || _filtro || '%';
			
	END

$$;
 9   DROP FUNCTION usuarios.f_obtener_usuarios(_filtro text);
       usuarios       postgres    false    217    6         �            1259    17103    agenda    TABLE     g  CREATE TABLE proyecto1.agenda (
    id_agenda integer NOT NULL,
    empleado_id integer NOT NULL,
    cliente_id integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    servicio_id integer NOT NULL,
    precio integer NOT NULL,
    estado_id integer NOT NULL,
    comentarios_emp text NOT NULL,
    comentarios_cli text NOT NULL
);
    DROP TABLE proyecto1.agenda;
    	   proyecto1         postgres    false    11         �            1259    17101    agenda_id_agenda_seq    SEQUENCE     �   CREATE SEQUENCE proyecto1.agenda_id_agenda_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE proyecto1.agenda_id_agenda_seq;
    	   proyecto1       postgres    false    11    207         �           0    0    agenda_id_agenda_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE proyecto1.agenda_id_agenda_seq OWNED BY proyecto1.agenda.id_agenda;
         	   proyecto1       postgres    false    206         �            1259    17114    emp_serv    TABLE     �   CREATE TABLE proyecto1.emp_serv (
    id_empser integer NOT NULL,
    empleado_id integer NOT NULL,
    servicio_id integer NOT NULL
);
    DROP TABLE proyecto1.emp_serv;
    	   proyecto1         postgres    false    11         �            1259    17112    emp_serv_id_empser_seq    SEQUENCE     �   CREATE SEQUENCE proyecto1.emp_serv_id_empser_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE proyecto1.emp_serv_id_empser_seq;
    	   proyecto1       postgres    false    209    11         �           0    0    emp_serv_id_empser_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE proyecto1.emp_serv_id_empser_seq OWNED BY proyecto1.emp_serv.id_empser;
         	   proyecto1       postgres    false    208         �            1259    17122 
   estado_ser    TABLE     a   CREATE TABLE proyecto1.estado_ser (
    id_estado integer NOT NULL,
    nom_est text NOT NULL
);
 !   DROP TABLE proyecto1.estado_ser;
    	   proyecto1         postgres    false    11         �            1259    17120    estado_ser_id_estado_seq    SEQUENCE     �   CREATE SEQUENCE proyecto1.estado_ser_id_estado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE proyecto1.estado_ser_id_estado_seq;
    	   proyecto1       postgres    false    11    211         �           0    0    estado_ser_id_estado_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE proyecto1.estado_ser_id_estado_seq OWNED BY proyecto1.estado_ser.id_estado;
         	   proyecto1       postgres    false    210         �            1259    17095    horario    TABLE     �   CREATE TABLE proyecto1.horario (
    id_horario integer NOT NULL,
    empleado_id integer NOT NULL,
    horario date NOT NULL
);
    DROP TABLE proyecto1.horario;
    	   proyecto1         postgres    false    11         �            1259    17093    horario_id_horario_seq    SEQUENCE     �   CREATE SEQUENCE proyecto1.horario_id_horario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE proyecto1.horario_id_horario_seq;
    	   proyecto1       postgres    false    205    11         �           0    0    horario_id_horario_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE proyecto1.horario_id_horario_seq OWNED BY proyecto1.horario.id_horario;
         	   proyecto1       postgres    false    204         �            1259    17073    rol    TABLE     W   CREATE TABLE proyecto1.rol (
    id_rol integer NOT NULL,
    nom_rol text NOT NULL
);
    DROP TABLE proyecto1.rol;
    	   proyecto1         postgres    false    11         �            1259    17071    rol_id_rol_seq    SEQUENCE     �   CREATE SEQUENCE proyecto1.rol_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE proyecto1.rol_id_rol_seq;
    	   proyecto1       postgres    false    11    201         �           0    0    rol_id_rol_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE proyecto1.rol_id_rol_seq OWNED BY proyecto1.rol.id_rol;
         	   proyecto1       postgres    false    200         �            1259    17084    servicio    TABLE     �   CREATE TABLE proyecto1.servicio (
    id_ser integer NOT NULL,
    nom_ser text NOT NULL,
    costo integer NOT NULL,
    tiempo text NOT NULL
);
    DROP TABLE proyecto1.servicio;
    	   proyecto1         postgres    false    11         �            1259    17082    servicio_id_ser_seq    SEQUENCE     �   CREATE SEQUENCE proyecto1.servicio_id_ser_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE proyecto1.servicio_id_ser_seq;
    	   proyecto1       postgres    false    11    203         �           0    0    servicio_id_ser_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE proyecto1.servicio_id_ser_seq OWNED BY proyecto1.servicio.id_ser;
         	   proyecto1       postgres    false    202         �            1259    17149    usuarios    TABLE     �   CREATE TABLE proyecto1.usuarios (
    id_usuario integer NOT NULL,
    nombre text NOT NULL,
    cedula integer NOT NULL,
    correo text NOT NULL,
    usuario text NOT NULL,
    clave text NOT NULL,
    rol_id integer NOT NULL
);
    DROP TABLE proyecto1.usuarios;
    	   proyecto1         postgres    false    11         �            1259    17147    usuarios_id_usuario_seq    SEQUENCE     �   CREATE SEQUENCE proyecto1.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE proyecto1.usuarios_id_usuario_seq;
    	   proyecto1       postgres    false    11    213         �           0    0    usuarios_id_usuario_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE proyecto1.usuarios_id_usuario_seq OWNED BY proyecto1.usuarios.id_usuario;
         	   proyecto1       postgres    false    212         �            1259    17237    v_servicios    VIEW     {   CREATE VIEW proyecto1.v_servicios AS
 SELECT 0 AS id_ser,
    ''::text AS nom_ser,
    0 AS costo,
    ''::text AS tiempo;
 !   DROP VIEW proyecto1.v_servicios;
    	   proyecto1       postgres    false    11         �            1259    25262 	   auditoria    TABLE     T  CREATE TABLE security.auditoria (
    id bigint NOT NULL,
    fecha timestamp without time zone NOT NULL,
    accion character varying(100),
    schema character varying(200) NOT NULL,
    tabla character varying(200),
    session text NOT NULL,
    user_bd character varying(100) NOT NULL,
    data jsonb NOT NULL,
    pk text NOT NULL
);
    DROP TABLE security.auditoria;
       security         postgres    false    8         �           0    0    TABLE auditoria    COMMENT     a   COMMENT ON TABLE security.auditoria IS 'Tabla que almacena la trazabilidad de la informaicón.';
            security       postgres    false    221         �           0    0    COLUMN auditoria.id    COMMENT     D   COMMENT ON COLUMN security.auditoria.id IS 'campo pk de la tabla ';
            security       postgres    false    221         �           0    0    COLUMN auditoria.fecha    COMMENT     Z   COMMENT ON COLUMN security.auditoria.fecha IS 'ALmacen ala la fecha de la modificación';
            security       postgres    false    221         �           0    0    COLUMN auditoria.accion    COMMENT     f   COMMENT ON COLUMN security.auditoria.accion IS 'Almacena la accion que se ejecuto sobre el registro';
            security       postgres    false    221         �           0    0    COLUMN auditoria.schema    COMMENT     m   COMMENT ON COLUMN security.auditoria.schema IS 'Almanena el nomnbre del schema de la tabla que se modifico';
            security       postgres    false    221         �           0    0    COLUMN auditoria.tabla    COMMENT     `   COMMENT ON COLUMN security.auditoria.tabla IS 'Almacena el nombre de la tabla que se modifico';
            security       postgres    false    221         �           0    0    COLUMN auditoria.session    COMMENT     p   COMMENT ON COLUMN security.auditoria.session IS 'Campo que almacena el id de la session que generó el cambio';
            security       postgres    false    221         �           0    0    COLUMN auditoria.user_bd    COMMENT     �   COMMENT ON COLUMN security.auditoria.user_bd IS 'Campo que almacena el user que se autentico en el motor para generar el cmabio';
            security       postgres    false    221         �           0    0    COLUMN auditoria.data    COMMENT     d   COMMENT ON COLUMN security.auditoria.data IS 'campo que almacena la modificaicón que se realizó';
            security       postgres    false    221         �           0    0    COLUMN auditoria.pk    COMMENT     W   COMMENT ON COLUMN security.auditoria.pk IS 'Campo que identifica el id del registro.';
            security       postgres    false    221         �            1259    25268    auditoria_id_seq    SEQUENCE     {   CREATE SEQUENCE security.auditoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE security.auditoria_id_seq;
       security       postgres    false    221    8         �           0    0    auditoria_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE security.auditoria_id_seq OWNED BY security.auditoria.id;
            security       postgres    false    222         �            1259    25270    autenication    TABLE     �   CREATE TABLE security.autenication (
    id bigint NOT NULL,
    user_id integer,
    ip character varying(100),
    mac character varying(100),
    fecha_inicio timestamp without time zone,
    session text,
    fecha_fin timestamp without time zone
);
 "   DROP TABLE security.autenication;
       security         postgres    false    8         �           0    0    TABLE autenication    COMMENT     o   COMMENT ON TABLE security.autenication IS 'Tabla que almacena las autenticaciones por parte de los usuarios.';
            security       postgres    false    223         �           0    0    COLUMN autenication.id    COMMENT     F   COMMENT ON COLUMN security.autenication.id IS 'campo pk de la tabla';
            security       postgres    false    223         �           0    0    COLUMN autenication.user_id    COMMENT     V   COMMENT ON COLUMN security.autenication.user_id IS 'Campo que identifica el usuario';
            security       postgres    false    223         �           0    0    COLUMN autenication.ip    COMMENT     Y   COMMENT ON COLUMN security.autenication.ip IS 'Cmapo que almacena la ip de la maquina.';
            security       postgres    false    223         �           0    0    COLUMN autenication.mac    COMMENT     X   COMMENT ON COLUMN security.autenication.mac IS 'Campo que almacena la MAC del equipo.';
            security       postgres    false    223         �           0    0     COLUMN autenication.fecha_inicio    COMMENT     a   COMMENT ON COLUMN security.autenication.fecha_inicio IS 'Captura la fecha de inicio de session';
            security       postgres    false    223         �           0    0    COLUMN autenication.session    COMMENT     `   COMMENT ON COLUMN security.autenication.session IS 'Campo que almacena la session del usuario';
            security       postgres    false    223         �           0    0    COLUMN autenication.fecha_fin    COMMENT     j   COMMENT ON COLUMN security.autenication.fecha_fin IS 'Cmapo que lamacena la feccha de cierre de session';
            security       postgres    false    223         �            1259    25276    autenication_id_seq    SEQUENCE     ~   CREATE SEQUENCE security.autenication_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE security.autenication_id_seq;
       security       postgres    false    223    8         �           0    0    autenication_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE security.autenication_id_seq OWNED BY security.autenication.id;
            security       postgres    false    224         �            1259    25278    function_db_view    VIEW     �  CREATE VIEW security.function_db_view AS
 SELECT pp.proname AS b_function,
    oidvectortypes(pp.proargtypes) AS b_type_parameters
   FROM (pg_proc pp
     JOIN pg_namespace pn ON ((pn.oid = pp.pronamespace)))
  WHERE ((pn.nspname)::text <> ALL (ARRAY[('pg_catalog'::character varying)::text, ('information_schema'::character varying)::text, ('admin_control'::character varying)::text, ('vial'::character varying)::text]));
 %   DROP VIEW security.function_db_view;
       security       postgres    false    8         �            1259    25398    prueba    TABLE     f   CREATE TABLE servicios.prueba (
    id_ser integer NOT NULL,
    nom_ser text,
    f_servicio text
);
    DROP TABLE servicios.prueba;
    	   servicios         postgres    false    10         �            1259    25396    prueba_id_ser_seq    SEQUENCE     �   CREATE SEQUENCE servicios.prueba_id_ser_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE servicios.prueba_id_ser_seq;
    	   servicios       postgres    false    10    231         �           0    0    prueba_id_ser_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE servicios.prueba_id_ser_seq OWNED BY servicios.prueba.id_ser;
         	   servicios       postgres    false    230         �            1259    25297    servicio    TABLE     �   CREATE TABLE servicios.servicio (
    id_ser integer NOT NULL,
    nom_ser text,
    costo integer,
    tiempo text,
    f_servicio text,
    descripcion text
);
    DROP TABLE servicios.servicio;
    	   servicios         postgres    false    10         �            1259    25295    servicio_id_ser_seq    SEQUENCE     �   CREATE SEQUENCE servicios.servicio_id_ser_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE servicios.servicio_id_ser_seq;
    	   servicios       postgres    false    227    10         �           0    0    servicio_id_ser_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE servicios.servicio_id_ser_seq OWNED BY servicios.servicio.id_ser;
         	   servicios       postgres    false    226         �            1259    17577    roles    TABLE     [   CREATE TABLE usuarios.roles (
    id_rol integer NOT NULL,
    nombre_rol text NOT NULL
);
    DROP TABLE usuarios.roles;
       usuarios         postgres    false    6         �            1259    17586    usuarios_id_usuario_seq    SEQUENCE     �   CREATE SEQUENCE usuarios.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE usuarios.usuarios_id_usuario_seq;
       usuarios       postgres    false    217    6         �           0    0    usuarios_id_usuario_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE usuarios.usuarios_id_usuario_seq OWNED BY usuarios.usuarios.id_usuario;
            usuarios       postgres    false    218                    2604    17588    agenda id_agenda    DEFAULT     z   ALTER TABLE ONLY proyecto1.agenda ALTER COLUMN id_agenda SET DEFAULT nextval('proyecto1.agenda_id_agenda_seq'::regclass);
 B   ALTER TABLE proyecto1.agenda ALTER COLUMN id_agenda DROP DEFAULT;
    	   proyecto1       postgres    false    206    207    207                    2604    17589    emp_serv id_empser    DEFAULT     ~   ALTER TABLE ONLY proyecto1.emp_serv ALTER COLUMN id_empser SET DEFAULT nextval('proyecto1.emp_serv_id_empser_seq'::regclass);
 D   ALTER TABLE proyecto1.emp_serv ALTER COLUMN id_empser DROP DEFAULT;
    	   proyecto1       postgres    false    209    208    209                    2604    17590    estado_ser id_estado    DEFAULT     �   ALTER TABLE ONLY proyecto1.estado_ser ALTER COLUMN id_estado SET DEFAULT nextval('proyecto1.estado_ser_id_estado_seq'::regclass);
 F   ALTER TABLE proyecto1.estado_ser ALTER COLUMN id_estado DROP DEFAULT;
    	   proyecto1       postgres    false    210    211    211                    2604    17591    horario id_horario    DEFAULT     ~   ALTER TABLE ONLY proyecto1.horario ALTER COLUMN id_horario SET DEFAULT nextval('proyecto1.horario_id_horario_seq'::regclass);
 D   ALTER TABLE proyecto1.horario ALTER COLUMN id_horario DROP DEFAULT;
    	   proyecto1       postgres    false    204    205    205                    2604    17592 
   rol id_rol    DEFAULT     n   ALTER TABLE ONLY proyecto1.rol ALTER COLUMN id_rol SET DEFAULT nextval('proyecto1.rol_id_rol_seq'::regclass);
 <   ALTER TABLE proyecto1.rol ALTER COLUMN id_rol DROP DEFAULT;
    	   proyecto1       postgres    false    201    200    201                    2604    17593    servicio id_ser    DEFAULT     x   ALTER TABLE ONLY proyecto1.servicio ALTER COLUMN id_ser SET DEFAULT nextval('proyecto1.servicio_id_ser_seq'::regclass);
 A   ALTER TABLE proyecto1.servicio ALTER COLUMN id_ser DROP DEFAULT;
    	   proyecto1       postgres    false    203    202    203                    2604    17594    usuarios id_usuario    DEFAULT     �   ALTER TABLE ONLY proyecto1.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('proyecto1.usuarios_id_usuario_seq'::regclass);
 E   ALTER TABLE proyecto1.usuarios ALTER COLUMN id_usuario DROP DEFAULT;
    	   proyecto1       postgres    false    212    213    213         	           2604    25283    auditoria id    DEFAULT     p   ALTER TABLE ONLY security.auditoria ALTER COLUMN id SET DEFAULT nextval('security.auditoria_id_seq'::regclass);
 =   ALTER TABLE security.auditoria ALTER COLUMN id DROP DEFAULT;
       security       postgres    false    222    221         
           2604    25284    autenication id    DEFAULT     v   ALTER TABLE ONLY security.autenication ALTER COLUMN id SET DEFAULT nextval('security.autenication_id_seq'::regclass);
 @   ALTER TABLE security.autenication ALTER COLUMN id DROP DEFAULT;
       security       postgres    false    224    223                    2604    25401    prueba id_ser    DEFAULT     t   ALTER TABLE ONLY servicios.prueba ALTER COLUMN id_ser SET DEFAULT nextval('servicios.prueba_id_ser_seq'::regclass);
 ?   ALTER TABLE servicios.prueba ALTER COLUMN id_ser DROP DEFAULT;
    	   servicios       postgres    false    230    231    231                    2604    25300    servicio id_ser    DEFAULT     x   ALTER TABLE ONLY servicios.servicio ALTER COLUMN id_ser SET DEFAULT nextval('servicios.servicio_id_ser_seq'::regclass);
 A   ALTER TABLE servicios.servicio ALTER COLUMN id_ser DROP DEFAULT;
    	   servicios       postgres    false    227    226    227                    2604    17595    usuarios id_usuario    DEFAULT     ~   ALTER TABLE ONLY usuarios.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('usuarios.usuarios_id_usuario_seq'::regclass);
 D   ALTER TABLE usuarios.usuarios ALTER COLUMN id_usuario DROP DEFAULT;
       usuarios       postgres    false    218    217         �          0    17103    agenda 
   TABLE DATA               �   COPY proyecto1.agenda (id_agenda, empleado_id, cliente_id, fecha_inicio, fecha_fin, servicio_id, precio, estado_id, comentarios_emp, comentarios_cli) FROM stdin;
 	   proyecto1       postgres    false    207       3008.dat �          0    17114    emp_serv 
   TABLE DATA               J   COPY proyecto1.emp_serv (id_empser, empleado_id, servicio_id) FROM stdin;
 	   proyecto1       postgres    false    209       3010.dat �          0    17122 
   estado_ser 
   TABLE DATA               ;   COPY proyecto1.estado_ser (id_estado, nom_est) FROM stdin;
 	   proyecto1       postgres    false    211       3012.dat �          0    17095    horario 
   TABLE DATA               F   COPY proyecto1.horario (id_horario, empleado_id, horario) FROM stdin;
 	   proyecto1       postgres    false    205       3006.dat �          0    17073    rol 
   TABLE DATA               1   COPY proyecto1.rol (id_rol, nom_rol) FROM stdin;
 	   proyecto1       postgres    false    201       3002.dat �          0    17084    servicio 
   TABLE DATA               E   COPY proyecto1.servicio (id_ser, nom_ser, costo, tiempo) FROM stdin;
 	   proyecto1       postgres    false    203       3004.dat �          0    17149    usuarios 
   TABLE DATA               a   COPY proyecto1.usuarios (id_usuario, nombre, cedula, correo, usuario, clave, rol_id) FROM stdin;
 	   proyecto1       postgres    false    213       3014.dat �          0    25262 	   auditoria 
   TABLE DATA               c   COPY security.auditoria (id, fecha, accion, schema, tabla, session, user_bd, data, pk) FROM stdin;
    security       postgres    false    221       3018.dat �          0    25270    autenication 
   TABLE DATA               `   COPY security.autenication (id, user_id, ip, mac, fecha_inicio, session, fecha_fin) FROM stdin;
    security       postgres    false    223       3020.dat �          0    25398    prueba 
   TABLE DATA               @   COPY servicios.prueba (id_ser, nom_ser, f_servicio) FROM stdin;
 	   servicios       postgres    false    231       3025.dat �          0    25297    servicio 
   TABLE DATA               ^   COPY servicios.servicio (id_ser, nom_ser, costo, tiempo, f_servicio, descripcion) FROM stdin;
 	   servicios       postgres    false    227       3023.dat �          0    17577    roles 
   TABLE DATA               5   COPY usuarios.roles (id_rol, nombre_rol) FROM stdin;
    usuarios       postgres    false    216       3015.dat �          0    17580    usuarios 
   TABLE DATA               �   COPY usuarios.usuarios (id_usuario, nombre, apellido, numero_identificacion, correo, usuario, clave, rol_id, session, tipo_identificacion, create_date) FROM stdin;
    usuarios       postgres    false    217       3016.dat �           0    0    agenda_id_agenda_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('proyecto1.agenda_id_agenda_seq', 1, false);
         	   proyecto1       postgres    false    206         �           0    0    emp_serv_id_empser_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('proyecto1.emp_serv_id_empser_seq', 1, false);
         	   proyecto1       postgres    false    208         �           0    0    estado_ser_id_estado_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('proyecto1.estado_ser_id_estado_seq', 1, false);
         	   proyecto1       postgres    false    210         �           0    0    horario_id_horario_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('proyecto1.horario_id_horario_seq', 1, false);
         	   proyecto1       postgres    false    204         �           0    0    rol_id_rol_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('proyecto1.rol_id_rol_seq', 1, false);
         	   proyecto1       postgres    false    200         �           0    0    servicio_id_ser_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('proyecto1.servicio_id_ser_seq', 5, true);
         	   proyecto1       postgres    false    202         �           0    0    usuarios_id_usuario_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('proyecto1.usuarios_id_usuario_seq', 6, true);
         	   proyecto1       postgres    false    212         �           0    0    auditoria_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('security.auditoria_id_seq', 34, true);
            security       postgres    false    222         �           0    0    autenication_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('security.autenication_id_seq', 56, true);
            security       postgres    false    224                     0    0    prueba_id_ser_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('servicios.prueba_id_ser_seq', 1, true);
         	   servicios       postgres    false    230                    0    0    servicio_id_ser_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('servicios.servicio_id_ser_seq', 6, true);
         	   servicios       postgres    false    226                    0    0    usuarios_id_usuario_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('usuarios.usuarios_id_usuario_seq', 11, true);
            usuarios       postgres    false    218                    2606    17111    agenda pk_proyecto1_agenda 
   CONSTRAINT     b   ALTER TABLE ONLY proyecto1.agenda
    ADD CONSTRAINT pk_proyecto1_agenda PRIMARY KEY (id_agenda);
 G   ALTER TABLE ONLY proyecto1.agenda DROP CONSTRAINT pk_proyecto1_agenda;
    	   proyecto1         postgres    false    207                    2606    17119    emp_serv pk_proyecto1_empserv 
   CONSTRAINT     e   ALTER TABLE ONLY proyecto1.emp_serv
    ADD CONSTRAINT pk_proyecto1_empserv PRIMARY KEY (id_empser);
 J   ALTER TABLE ONLY proyecto1.emp_serv DROP CONSTRAINT pk_proyecto1_empserv;
    	   proyecto1         postgres    false    209                    2606    17130 !   estado_ser pk_proyecto1_estadoser 
   CONSTRAINT     i   ALTER TABLE ONLY proyecto1.estado_ser
    ADD CONSTRAINT pk_proyecto1_estadoser PRIMARY KEY (id_estado);
 N   ALTER TABLE ONLY proyecto1.estado_ser DROP CONSTRAINT pk_proyecto1_estadoser;
    	   proyecto1         postgres    false    211                    2606    17100    horario pk_proyecto1_horario 
   CONSTRAINT     e   ALTER TABLE ONLY proyecto1.horario
    ADD CONSTRAINT pk_proyecto1_horario PRIMARY KEY (id_horario);
 I   ALTER TABLE ONLY proyecto1.horario DROP CONSTRAINT pk_proyecto1_horario;
    	   proyecto1         postgres    false    205                    2606    17081    rol pk_proyecto1_rol 
   CONSTRAINT     Y   ALTER TABLE ONLY proyecto1.rol
    ADD CONSTRAINT pk_proyecto1_rol PRIMARY KEY (id_rol);
 A   ALTER TABLE ONLY proyecto1.rol DROP CONSTRAINT pk_proyecto1_rol;
    	   proyecto1         postgres    false    201                    2606    17092    servicio pk_proyecto1_servicio 
   CONSTRAINT     c   ALTER TABLE ONLY proyecto1.servicio
    ADD CONSTRAINT pk_proyecto1_servicio PRIMARY KEY (id_ser);
 K   ALTER TABLE ONLY proyecto1.servicio DROP CONSTRAINT pk_proyecto1_servicio;
    	   proyecto1         postgres    false    203         !           2606    17157    usuarios pk_proyecto1_usuario 
   CONSTRAINT     f   ALTER TABLE ONLY proyecto1.usuarios
    ADD CONSTRAINT pk_proyecto1_usuario PRIMARY KEY (id_usuario);
 J   ALTER TABLE ONLY proyecto1.usuarios DROP CONSTRAINT pk_proyecto1_usuario;
    	   proyecto1         postgres    false    213         *           2606    25286    auditoria pk_security_auditoria 
   CONSTRAINT     _   ALTER TABLE ONLY security.auditoria
    ADD CONSTRAINT pk_security_auditoria PRIMARY KEY (id);
 K   ALTER TABLE ONLY security.auditoria DROP CONSTRAINT pk_security_auditoria;
       security         postgres    false    221         ,           2606    25288 %   autenication pk_security_autenication 
   CONSTRAINT     e   ALTER TABLE ONLY security.autenication
    ADD CONSTRAINT pk_security_autenication PRIMARY KEY (id);
 Q   ALTER TABLE ONLY security.autenication DROP CONSTRAINT pk_security_autenication;
       security         postgres    false    223         0           2606    25406    prueba pk_servicios_prueba 
   CONSTRAINT     _   ALTER TABLE ONLY servicios.prueba
    ADD CONSTRAINT pk_servicios_prueba PRIMARY KEY (id_ser);
 G   ALTER TABLE ONLY servicios.prueba DROP CONSTRAINT pk_servicios_prueba;
    	   servicios         postgres    false    231         .           2606    25305    servicio pk_servicios_servicio 
   CONSTRAINT     c   ALTER TABLE ONLY servicios.servicio
    ADD CONSTRAINT pk_servicios_servicio PRIMARY KEY (id_ser);
 K   ALTER TABLE ONLY servicios.servicio DROP CONSTRAINT pk_servicios_servicio;
    	   servicios         postgres    false    227         #           2606    17597    roles pk_usuarios_roles 
   CONSTRAINT     [   ALTER TABLE ONLY usuarios.roles
    ADD CONSTRAINT pk_usuarios_roles PRIMARY KEY (id_rol);
 C   ALTER TABLE ONLY usuarios.roles DROP CONSTRAINT pk_usuarios_roles;
       usuarios         postgres    false    216         &           2606    17599    usuarios pk_usuarios_usuarios 
   CONSTRAINT     e   ALTER TABLE ONLY usuarios.usuarios
    ADD CONSTRAINT pk_usuarios_usuarios PRIMARY KEY (id_usuario);
 I   ALTER TABLE ONLY usuarios.usuarios DROP CONSTRAINT pk_usuarios_usuarios;
       usuarios         postgres    false    217         (           2606    25227    usuarios u__nombre 
   CONSTRAINT     Q   ALTER TABLE ONLY usuarios.usuarios
    ADD CONSTRAINT u__nombre UNIQUE (nombre);
 >   ALTER TABLE ONLY usuarios.usuarios DROP CONSTRAINT u__nombre;
       usuarios         postgres    false    217                    1259    17199    fki_agenda_estado    INDEX     L   CREATE INDEX fki_agenda_estado ON proyecto1.agenda USING btree (estado_id);
 (   DROP INDEX proyecto1.fki_agenda_estado;
    	   proyecto1         postgres    false    207                    1259    17193    fki_agenda_servicio    INDEX     P   CREATE INDEX fki_agenda_servicio ON proyecto1.agenda USING btree (servicio_id);
 *   DROP INDEX proyecto1.fki_agenda_servicio;
    	   proyecto1         postgres    false    207                    1259    17181    fki_agenda_user    INDEX     L   CREATE INDEX fki_agenda_user ON proyecto1.agenda USING btree (empleado_id);
 &   DROP INDEX proyecto1.fki_agenda_user;
    	   proyecto1         postgres    false    207                    1259    17187    fki_agenda_usercli    INDEX     N   CREATE INDEX fki_agenda_usercli ON proyecto1.agenda USING btree (cliente_id);
 )   DROP INDEX proyecto1.fki_agenda_usercli;
    	   proyecto1         postgres    false    207                    1259    17169    fki_empser_user    INDEX     N   CREATE INDEX fki_empser_user ON proyecto1.emp_serv USING btree (empleado_id);
 &   DROP INDEX proyecto1.fki_empser_user;
    	   proyecto1         postgres    false    209                    1259    17175    fki_horario_user    INDEX     N   CREATE INDEX fki_horario_user ON proyecto1.horario USING btree (empleado_id);
 '   DROP INDEX proyecto1.fki_horario_user;
    	   proyecto1         postgres    false    205                    1259    17163    fki_usuario_rol    INDEX     I   CREATE INDEX fki_usuario_rol ON proyecto1.usuarios USING btree (rol_id);
 &   DROP INDEX proyecto1.fki_usuario_rol;
    	   proyecto1         postgres    false    213         $           1259    17600    fki_fk_usuarios_roles    INDEX     N   CREATE INDEX fki_fk_usuarios_roles ON usuarios.usuarios USING btree (rol_id);
 +   DROP INDEX usuarios.fki_fk_usuarios_roles;
       usuarios         postgres    false    217         5           2606    17194    agenda agenda_estado    FK CONSTRAINT     �   ALTER TABLE ONLY proyecto1.agenda
    ADD CONSTRAINT agenda_estado FOREIGN KEY (estado_id) REFERENCES proyecto1.estado_ser(id_estado);
 A   ALTER TABLE ONLY proyecto1.agenda DROP CONSTRAINT agenda_estado;
    	   proyecto1       postgres    false    207    211    2846         4           2606    17188    agenda agenda_servicio    FK CONSTRAINT     �   ALTER TABLE ONLY proyecto1.agenda
    ADD CONSTRAINT agenda_servicio FOREIGN KEY (servicio_id) REFERENCES proyecto1.servicio(id_ser);
 C   ALTER TABLE ONLY proyecto1.agenda DROP CONSTRAINT agenda_servicio;
    	   proyecto1       postgres    false    203    2832    207         2           2606    17182    agenda agenda_usercli    FK CONSTRAINT     �   ALTER TABLE ONLY proyecto1.agenda
    ADD CONSTRAINT agenda_usercli FOREIGN KEY (cliente_id) REFERENCES proyecto1.usuarios(id_usuario);
 B   ALTER TABLE ONLY proyecto1.agenda DROP CONSTRAINT agenda_usercli;
    	   proyecto1       postgres    false    213    207    2849         3           2606    17176    agenda agenda_useremp    FK CONSTRAINT     �   ALTER TABLE ONLY proyecto1.agenda
    ADD CONSTRAINT agenda_useremp FOREIGN KEY (empleado_id) REFERENCES proyecto1.usuarios(id_usuario);
 B   ALTER TABLE ONLY proyecto1.agenda DROP CONSTRAINT agenda_useremp;
    	   proyecto1       postgres    false    207    2849    213         6           2606    17164    emp_serv empser_user    FK CONSTRAINT     �   ALTER TABLE ONLY proyecto1.emp_serv
    ADD CONSTRAINT empser_user FOREIGN KEY (empleado_id) REFERENCES proyecto1.usuarios(id_usuario);
 A   ALTER TABLE ONLY proyecto1.emp_serv DROP CONSTRAINT empser_user;
    	   proyecto1       postgres    false    209    2849    213         1           2606    17170    horario horario_user    FK CONSTRAINT     �   ALTER TABLE ONLY proyecto1.horario
    ADD CONSTRAINT horario_user FOREIGN KEY (empleado_id) REFERENCES proyecto1.usuarios(id_usuario);
 A   ALTER TABLE ONLY proyecto1.horario DROP CONSTRAINT horario_user;
    	   proyecto1       postgres    false    2849    213    205         7           2606    17158    usuarios usuario_rol    FK CONSTRAINT     z   ALTER TABLE ONLY proyecto1.usuarios
    ADD CONSTRAINT usuario_rol FOREIGN KEY (rol_id) REFERENCES proyecto1.rol(id_rol);
 A   ALTER TABLE ONLY proyecto1.usuarios DROP CONSTRAINT usuario_rol;
    	   proyecto1       postgres    false    2830    201    213         8           2606    17601    usuarios fk_usuarios_roles    FK CONSTRAINT     �   ALTER TABLE ONLY usuarios.usuarios
    ADD CONSTRAINT fk_usuarios_roles FOREIGN KEY (rol_id) REFERENCES usuarios.roles(id_rol);
 F   ALTER TABLE ONLY usuarios.usuarios DROP CONSTRAINT fk_usuarios_roles;
       usuarios       postgres    false    217    2851    216                                                                                                                                                                                                                                                                                                                                                                                                                                                                  3008.dat                                                                                            0000600 0004000 0002000 00000000005 13547124767 0014257 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3010.dat                                                                                            0000600 0004000 0002000 00000000005 13547124767 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3012.dat                                                                                            0000600 0004000 0002000 00000000005 13547124767 0014252 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3006.dat                                                                                            0000600 0004000 0002000 00000000005 13547124767 0014255 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3002.dat                                                                                            0000600 0004000 0002000 00000000045 13547124767 0014255 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	ADMI\n
2	Empleado\n
3	Cliente
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3004.dat                                                                                            0000600 0004000 0002000 00000000150 13547124767 0014254 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2	asdfg	356	jkl
3	Cabello	1345	2horas
4	Paola	1234	2horas
5	ñlkjh	4599	4horas
1	Corte	1200	2horas
\.


                                                                                                                                                                                                                                                                                                                                                                                                                        3014.dat                                                                                            0000600 0004000 0002000 00000000067 13547124767 0014264 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        4	Paola\n	11111123	paola_leon@df.com	apleon	abd	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                         3018.dat                                                                                            0000600 0004000 0002000 00000012131 13547124767 0014263 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	2017-10-21 12:02:57.600722	INSERT	usuario	usuario	hjbhjkbhjbhjkbjhk	postgres	{"id_nuevo": 4, "clave_nuevo": "546564564", "correo_nuevo": "gvghjvghv", "estado_nuevo": 1, "nombre_nuevo": "Andrea", "session_nuevo": "hjbhjkbhjbhjkbjhk", "user_name_nuevo": "perez", "last_modified_nuevo": "2017-10-01T10:00:00"}	4
2	2017-10-21 12:03:36.142078	UPDATE	usuario	usuario	hjbhjkbhjbhjkbjhk	postgres	{"nombre_nuevo": "Lucas", "nombre_anterior": "Andrea"}	4
3	2017-10-21 12:05:49.411708	DELETE	usuario	usuario	h	postgres	{"clave_old": "675675", "correo_old": "jhbhjghjghj", "estado_old": 1, "nombre_old": "Pedro", "id_anterior": 2, "session_old": "h", "user_name_old": "Perez", "last_modified_old": "2017-10-20T00:00:00"}	2
5	2017-10-21 12:16:12.32344	UPDATE	usuario	usuario	rfddjhdbhjfbadshjkfb	postgres	{"clave_nuevo": "123", "clave_anterior": "456"}	1
6	2018-03-20 07:14:54.117839	UPDATE	usuario	usuario	rfddjhdbhjfbadshjkfb	postgres	{"estado_nuevo": 1, "estado_anterior": 2}	1
7	2018-03-20 07:35:47.198175	UPDATE	usuario	usuario	rfddjhdbhjfbadshjkfb	postgres	{"estado_nuevo": 2, "estado_anterior": 1}	1
8	2018-03-20 07:36:24.843545	UPDATE	usuario	usuario	rfddjhdbhjfbadshjkfb	postgres	{"estado_nuevo": 1, "estado_anterior": 2}	1
9	2018-03-20 07:43:53.868063	UPDATE	usuario	usuario	rfddjhdbhjfbadshjkfb	postgres	{"estado_nuevo": 2, "estado_anterior": 1}	1
10	2018-03-20 08:02:08.894738	UPDATE	usuario	usuario	rfddjhdbhjfbadshjkfb	postgres	{"clave_nuevo": "456", "estado_nuevo": 1, "clave_anterior": "123", "estado_anterior": 2}	1
11	2018-03-24 09:39:25.052671	UPDATE	usuario	usuario	rfddjhdbhjfbadshjkfb	postgres	{"estado_nuevo": 2, "estado_anterior": 1}	1
12	2018-03-24 09:45:30.208377	UPDATE	usuario	usuario	rfddjhdbhjfbadshjkfb	postgres	{"estado_nuevo": 1, "estado_anterior": 2}	1
13	2018-03-24 09:45:43.345278	UPDATE	usuario	usuario	rfddjhdbhjfbadshjkfb	postgres	{"estado_nuevo": 2, "estado_anterior": 1}	1
14	2018-03-24 09:49:37.654802	UPDATE	usuario	usuario	rfddjhdbhjfbadshjkfb	postgres	{"clave_nuevo": "A1234567890a", "estado_nuevo": 1, "clave_anterior": "456", "estado_anterior": 2}	1
15	2018-03-24 10:12:19.272063	INSERT	usuario	usuario	qqqqq	postgres	{"id_nuevo": 5, "clave_nuevo": "456", "correo_nuevo": "comprueba@prueba.v", "estado_nuevo": 1, "nombre_nuevo": "Andrea", "session_nuevo": "qqqqq", "user_name_nuevo": "as", "last_modified_nuevo": "2001-01-01T00:00:00"}	5
16	2018-03-24 11:03:50.298868	UPDATE	usuario	roles		postgres	{"nombre_nuevo": "Ivan", "nombre_anterior": "prueba"}	1
17	2018-03-24 11:07:20.081504	DELETE	usuario	roles		postgres	{"nombre_old": "Ivan", "id_anterior": 1}	1
19	2018-04-03 14:51:42.249911	UPDATE	usuario	usuario	qqqqq	postgres	{}	5
20	2018-04-03 14:54:28.874066	UPDATE	usuario	usuario	qqqqq	postgres	{}	5
21	2018-04-03 15:18:12.0636	INSERT	usuario	roles		postgres	{"nombre_nuevo": "Administador"}	2
22	2018-04-03 15:20:49.904819	UPDATE	usuario	roles		postgres	{"nombre_nuevo": "AASDASD", "nombre_anterior": "Administador"}	2
23	2018-04-03 15:26:23.691722	UPDATE	usuario	usuario	hjbhjkbhjbhjkbjhk	postgres	{"nombre_nuevo": "Pedro", "nombre_anterior": "Lucas"}	4
24	2018-04-03 15:26:51.731036	UPDATE	usuario	roles		postgres	{"nombre_nuevo": "Lucas", "nombre_anterior": "AASDASD"}	2
25	2018-09-22 10:31:05.903053	UPDATE	usuario	usuario	rfddjhdbhjfbadshjkfb	postgres	{"clave_nuevo": "12345", "clave_anterior": "A1234567890a"}	1
26	2018-09-22 11:07:13.62709	UPDATE	usuario	usuario	hjbhjkbhjbhjkbjhk	postgres	{"clave_nuevo": "123", "rol_id_nuevo": 2, "clave_anterior": "546564564", "rol_id_anterior": 1}	4
27	2018-09-22 11:17:46.719817	UPDATE	usuario	usuario	rfddjhdbhjfbadshjkfb	postgres	{"estado_nuevo": 2, "estado_anterior": 1}	1
28	2018-09-22 11:43:00.199438	UPDATE	usuario	usuario	rfddjhdbhjfbadshjkfb	postgres	{"clave_nuevo": "zxc", "estado_nuevo": 1, "clave_anterior": "12345", "estado_anterior": 2}	1
29	2018-09-22 11:54:13.998361	DELETE	usuario	usuario	qqqqq	postgres	{"id_anterior": 5, "clave_anterior": "4789", "correo_anterior": "comprueba@prueba.v", "estado_anterior": 1, "nombre_anterior": "aaaaaaa", "rol_id_anterior": 1, "session_anterior": "qqqqq", "user_name_anterior": "dsfsdfsd", "last_modified_anterior": "2001-01-01T00:00:00"}	5
30	2018-09-22 12:14:20.218124	INSERT	usuario	token_repureacion_usuario		postgres	{"id_nuevo": 18, "token_nuevo": "prueba", "user_id_nuevo": 111, "fecha_creado_nuevo": "2018-01-01T00:00:00", "fecha_vigencia_nuevo": "2019-01-01T00:00:00"}	18
32	2019-10-03 20:25:39.86006	INSERT	usuario	usuario	rfddjhdbhjfbadshjkfb	postgres	{"id_nuevo": 6, "clave_nuevo": "2324", "correo_nuevo": "paola_leon1999@hotmail.com\\n", "estado_nuevo": 1, "nombre_nuevo": "paola", "rol_id_nuevo": 1, "session_nuevo": "rfddjhdbhjfbadshjkfb", "user_name_nuevo": "apleon", "last_modified_nuevo": "2017-10-01T00:00:00"}	6
33	2019-10-03 20:26:06.8077	UPDATE	usuario	usuario	rfddjhdbhjfbadshjkfb	postgres	{"estado_nuevo": 2, "estado_anterior": 1}	6
34	2019-10-03 20:26:11.30284	INSERT	usuario	token_repureacion_usuario		postgres	{"id_nuevo": 19, "token_nuevo": "b6806cefa92e2925de3ae9e18dcbb63815d4d2d693632dea8bdebc132bb8aad6", "user_id_nuevo": 6, "fecha_creado_nuevo": "2019-10-03T20:26:11.30284", "fecha_vigencia_nuevo": "2019-10-03T22:26:11.30284"}	19
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                       3020.dat                                                                                            0000600 0004000 0002000 00000010403 13547124767 0014254 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2	1	10.107.2.231	00-0C-29-0D-10-CE	2017-10-10 08:15:00.450992	prueba	\N
3	1	10.107.2.231	00-0C-29-0D-10-CE	2017-10-10 08:16:14.823731	prueba	\N
4	1	fe80::8f0:17fe:f594:fd18%2	\N	2017-10-10 08:16:38.096063	prueba	\N
6	1	10.107.2.231	00-0C-29-0D-10-CE	2017-10-10 08:18:24.543406	prueba	\N
7	1	10.107.2.231	00-0C-29-0D-10-CE	2017-10-10 08:18:37.499222	prueba	\N
8	1	fe80::1883:324c:f594:fd18%2	\N	2017-10-10 08:20:26.716506	prueba	\N
10	1	10.107.2.231	00-0C-29-0D-10-CE	2017-10-10 08:22:56.318306	prueba	\N
12	1	10.107.2.231	00-0C-29-0D-10-CE	2017-10-10 08:26:00.218497	prueba	\N
13	1	fe80::2828:37a4:f594:fd18%2	\N	2017-10-10 08:27:28.2941	prueba	\N
14	1	10.107.2.231	00-0C-29-0D-10-CE	2017-10-10 08:40:18.457837	obfxlnl4iu2ip0utwiq2kmu1	\N
15	1	fe80::306f:fa2:f594:fd18%2	\N	2017-10-10 08:44:31.87299	aa03vshfm5go2cm0dnskwc2e	2017-10-10 08:45:51.46492
16	1	10.107.2.231	00-0C-29-0D-10-CE	2017-10-10 08:45:35.253182	aa03vshfm5go2cm0dnskwc2e	2017-10-10 08:45:51.46492
17	1	10.107.2.231	000C290D10CE	2017-10-14 10:44:31.616763	bh0fmyspmgksrn4r5hv0owjv	\N
18	1	10.107.2.231	000C290D10CE	2017-10-14 10:54:16.267282	fpy3vefbgzafaq440onc4mc4	\N
19	1	10.107.2.231	000C290D10CE	2017-10-14 10:57:21.794502	3w0akvv3mbpvnjzsudx55t31	\N
21	1	10.107.2.231	000C290D10CE	2017-10-14 11:01:49.486056	nx11bvocxuooomvv0gzix0vq	\N
22	1	10.107.2.231	000C290D10CE	2017-10-14 11:02:31.651538	5jkrnhjnjwv2pcuineawemln	\N
25	1	10.107.2.231	000C290D10CE	2017-10-14 11:05:43.946197	1gsoaijvpsrgw10yw45viznp	\N
29	1	10.107.2.231	000C290D10CE	2017-10-17 08:33:53.781702	b3rnqyugnwkpuvwtrtltnqem	\N
30	1	192.168.43.128	000C29AE36C8	2018-03-20 07:22:52.815704	hgf4xhcsglgj5o0q45djqpev	2018-03-20 07:27:30.057936
31	1	192.168.0.14	000C29AE36C8	2018-03-24 09:50:13.922557	tcpm4skbr4ohzg2t5unhkf12	2018-03-24 09:50:41.096806
32	1	192.168.0.14	000C29AE36C8	2018-03-24 10:01:34.350608	tcpm4skbr4ohzg2t5unhkf12	\N
33	1	192.168.0.14	000C29AE36C8	2018-03-24 10:04:22.72232	n4vv0jmv0ackosm14n2cy04v	\N
34	1	192.168.217.128	000C297A35E7	2018-09-22 10:31:17.937551	22wd3j2ohuzgzvpztrpabovn	2018-09-22 10:41:46.725104
35	1	192.168.217.128	000C297A35E7	2018-09-22 10:39:31.356919	22wd3j2ohuzgzvpztrpabovn	2018-09-22 10:41:46.725104
38	1	192.168.217.128	000C297A35E7	2018-09-22 10:46:12.550638	phj0pwlozk4sgbtuyvxrgysx	\N
36	1	192.168.217.128	000C297A35E7	2018-09-22 10:42:42.139449	dynljkfxk5kbijyo1zgtimp2	2018-09-22 10:47:31.497879
37	1	192.168.217.128	000C297A35E7	2018-09-22 10:45:22.954319	dynljkfxk5kbijyo1zgtimp2	2018-09-22 10:47:31.497879
39	4	192.168.217.128	000C297A35E7	2018-09-22 11:08:21.070291	qjtokcbyerlt4chewh3tezqn	\N
40	1	192.168.217.128	000C297A35E7	2018-09-22 11:43:14.594317	0xmolzq32zn053klujv03l22	\N
41	1	192.168.217.128	000C297A35E7	2018-09-22 11:45:17.467885	wm11cgj3va0j5ttw32hyig0e	\N
42	1	192.168.217.128	000C297A35E7	2018-09-22 11:47:09.659572	lml4urpyssycpmnd3imgvvh3	\N
43	4	10.157.15.210	DEF50551553D	2019-10-01 09:07:30.130454	sgv12zmvhi0mtaaoduig5bjd	2019-10-01 09:11:55.698688
44	1	10.157.15.210	DEF50551553D	2019-10-01 09:10:00.126497	sgv12zmvhi0mtaaoduig5bjd	2019-10-01 09:11:55.698688
45	4	10.157.15.210	DEF50551553D	2019-10-01 09:10:59.411885	sgv12zmvhi0mtaaoduig5bjd	2019-10-01 09:11:55.698688
46	1	10.157.15.210	DEF50551553D	2019-10-01 09:11:22.943744	sgv12zmvhi0mtaaoduig5bjd	2019-10-01 09:11:55.698688
47	1	192.168.1.4	DEF50551553D	2019-10-03 18:22:35.448022	lx0ediaihmd5ue0oe32rtp2m	2019-10-04 00:27:47.179469
48	10	192.168.1.4	DEF50551553D	2019-10-03 23:42:21.456923	lx0ediaihmd5ue0oe32rtp2m	2019-10-04 00:27:47.179469
49	10	192.168.1.4	DEF50551553D	2019-10-03 23:44:04.07898	lx0ediaihmd5ue0oe32rtp2m	2019-10-04 00:27:47.179469
50	10	192.168.1.4	DEF50551553D	2019-10-04 00:28:03.107061	lx0ediaihmd5ue0oe32rtp2m	\N
51	10	192.168.1.4	DEF50551553D	2019-10-04 18:26:11.013825	u5ncrg5qhujx4q1dsyj0y2ls	2019-10-04 18:31:17.167609
52	10	192.168.1.4	DEF50551553D	2019-10-04 18:28:29.275195	u5ncrg5qhujx4q1dsyj0y2ls	2019-10-04 18:31:17.167609
53	10	192.168.1.4	DEF50551553D	2019-10-04 18:31:09.857666	u5ncrg5qhujx4q1dsyj0y2ls	2019-10-04 18:31:17.167609
54	10	192.168.1.4	DEF50551553D	2019-10-05 06:44:01.945335	nlaumxoy3hg1crnfr2s1rl14	\N
55	10	127.0.0.1	DEF50551553D	2019-10-05 10:21:33.759045	slrbpsdkjo5nbrccuvlqrump	2019-10-05 12:57:40.888142
56	10	10.157.15.54	DEF50551553D	2019-10-05 11:19:54.921621	slrbpsdkjo5nbrccuvlqrump	2019-10-05 12:57:40.888142
\.


                                                                                                                                                                                                                                                             3025.dat                                                                                            0000600 0004000 0002000 00000000060 13547124767 0014257 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	fondo.jpg	~\\Archivos\\FotosS\\fondo.jpg
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                3023.dat                                                                                            0000600 0004000 0002000 00000000276 13547124767 0014266 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2	asdfgh	1400	1h	\N	\N
4	dfg	1200	2horas	\N	\N
5	jose	12300	2h	~\\Archivos\\FotosS\\pruea.jpg	bueno
6	aaaasdf	2345	2h	~\\Archivos\\FotosS\\System.Web.UI.WebControls.TextBox.jpg	sadfghj
\.


                                                                                                                                                                                                                                                                                                                                  3015.dat                                                                                            0000600 0004000 0002000 00000000047 13547124767 0014263 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2	empleado
3	cliente
1	administra
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         3016.dat                                                                                            0000600 0004000 0002000 00000000256 13547124767 0014266 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        10	Leidy	Rodriguez	1789654123	is2637770@gmail.com	prueba1	123abc	1	1fx25lct14b2td0zfmro3cgh	1	\N
11	ty	tfy	678	yibb@hotmail.com	sdfg	123	3	lx0ediaihmd5ue0oe32rtp2m	1	\N
\.


                                                                                                                                                                                                                                                                                                                                                  restore.sql                                                                                         0000600 0004000 0002000 00000142020 13547124767 0015403 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE proyectopr1;
--
-- Name: proyectopr1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE proyectopr1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Spain.1252' LC_CTYPE = 'Spanish_Spain.1252';


ALTER DATABASE proyectopr1 OWNER TO postgres;

\connect proyectopr1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: proyecto1; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA proyecto1;


ALTER SCHEMA proyecto1 OWNER TO postgres;

--
-- Name: security; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA security;


ALTER SCHEMA security OWNER TO postgres;

--
-- Name: SCHEMA security; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA security IS 'Schema que se encarga de almacenar el tema de seguridad.';


--
-- Name: servicios; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA servicios;


ALTER SCHEMA servicios OWNER TO postgres;

--
-- Name: usuarios; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA usuarios;


ALTER SCHEMA usuarios OWNER TO postgres;

--
-- Name: f_cerrar_sesion(text); Type: FUNCTION; Schema: proyecto1; Owner: postgres
--

CREATE FUNCTION proyecto1.f_cerrar_sesion(_sesion text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	
	BEGIN
		UPDATE
			proyecto1.autenticacion
		SET
			fecha_fin = current_timestamp
		WHERE
			sesion = _sesion;			
	END
	
$$;


ALTER FUNCTION proyecto1.f_cerrar_sesion(_sesion text) OWNER TO postgres;

--
-- Name: f_guardado_sesion(integer, character varying, character varying, text); Type: FUNCTION; Schema: proyecto1; Owner: postgres
--

CREATE FUNCTION proyecto1.f_guardado_sesion(_user_id integer, _ip character varying, _mac character varying, _sesion text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	
	BEGIN
		INSERT INTO proyecto1.autenticacion
		(
			user_id,
			ip,
			mac,
			fecha_inicio,
			sesion
		)
	VALUES 
		(
			_user_id,
			_ip,
			_mac,
			current_timestamp,
			_sesion
		);	
		
	END

$$;


ALTER FUNCTION proyecto1.f_guardado_sesion(_user_id integer, _ip character varying, _mac character varying, _sesion text) OWNER TO postgres;

--
-- Name: f_insertar_servicio(text, integer, text); Type: FUNCTION; Schema: proyecto1; Owner: postgres
--

CREATE FUNCTION proyecto1.f_insertar_servicio(_nom_ser text, _costo integer, _tiempo text) RETURNS SETOF boolean
    LANGUAGE plpgsql
    AS $$
	DECLARE
		_cantidad integer;
	BEGIN
		_cantidad := (SELECT COUNT(*) FROM proyecto1.servicio WHERE nom_ser = _nom_ser);

		IF _cantidad = 0
		THEN
			INSERT INTO 
			proyecto1.servicio
			(
				nom_ser, 
				costo,
				tiempo
			)
			VALUES
			(
			_nom_ser,
			_costo,
			_tiempo
			);

			RETURN QUERY SELECT TRUE;
			ELSE
			RETURN QUERY SELECT FALSE;
			END IF;
		END;
		$$;


ALTER FUNCTION proyecto1.f_insertar_servicio(_nom_ser text, _costo integer, _tiempo text) OWNER TO postgres;

--
-- Name: f_insertar_usuarios(text, text, text, integer, text); Type: FUNCTION; Schema: proyecto1; Owner: postgres
--

CREATE FUNCTION proyecto1.f_insertar_usuarios(_user_name text, _clave text, _nombre text, _cedula integer, _correo text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	begin
		
		INSERT INTO proyecto1.usuario
		(
			user_name,
			clave,
			nombre,
			cedula,
			correo
		)
		VALUES 
		(
			_user_name,
			_clave,
			_nombre,
			_cedula,
			_correo	
		);

	end

$$;


ALTER FUNCTION proyecto1.f_insertar_usuarios(_user_name text, _clave text, _nombre text, _cedula integer, _correo text) OWNER TO postgres;

--
-- Name: v_login; Type: VIEW; Schema: proyecto1; Owner: postgres
--

CREATE VIEW proyecto1.v_login AS
 SELECT 0 AS user_id,
    ''::text AS nombre,
    0 AS rol_id,
    ''::text AS rol_nombre;


ALTER TABLE proyecto1.v_login OWNER TO postgres;

--
-- Name: f_login(text, text); Type: FUNCTION; Schema: proyecto1; Owner: postgres
--

CREATE FUNCTION proyecto1.f_login(_usuario text, _clave text) RETURNS SETOF proyecto1.v_login
    LANGUAGE plpgsql
    AS $$
		BEGIN
			RETURN QUERY
			SELECT
				uu.id_usuario AS user_id,
				uu.nombre AS nombre,
				ur.id_rol AS rol_id,
				ur.nom_rol AS rol_nombre

			FROM
				proyecto1.usuarios uu JOIN proyecto1.rol ur ON ur.id_rol = uu.rol_id
			WHERE
				uu.usuario = _usuario
			AND
				uu.clave = _clave;
		END;
	$$;


ALTER FUNCTION proyecto1.f_login(_usuario text, _clave text) OWNER TO postgres;

--
-- Name: f_cerrar_session(text); Type: FUNCTION; Schema: security; Owner: postgres
--

CREATE FUNCTION security.f_cerrar_session(_session text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	
	BEGIN
		UPDATE
			security.autenication
		SET
			fecha_fin = current_timestamp
		WHERE
			session = _session;
			
	END

$$;


ALTER FUNCTION security.f_cerrar_session(_session text) OWNER TO postgres;

--
-- Name: f_guardado_session(integer, character varying, character varying, text); Type: FUNCTION; Schema: security; Owner: postgres
--

CREATE FUNCTION security.f_guardado_session(_user_id integer, _ip character varying, _mac character varying, _session text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
	
	BEGIN
		INSERT INTO security.autenication
		(
			user_id,
			ip,
			mac,
			fecha_inicio,
			session
		)
	VALUES 
		(
			_user_id,
			_ip,
			_mac,
			current_timestamp,
			_session
		);


		
		
	END

$$;


ALTER FUNCTION security.f_guardado_session(_user_id integer, _ip character varying, _mac character varying, _session text) OWNER TO postgres;

--
-- Name: f_log_auditoria(); Type: FUNCTION; Schema: security; Owner: postgres
--

CREATE FUNCTION security.f_log_auditoria() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	 DECLARE
		_pk TEXT :='';		-- Representa la llave primaria de la tabla que esta siedno modificada.
		_sql TEXT;		-- Variable para la creacion del procedured.
		_column_guia RECORD; 	-- Variable para el FOR guarda los nombre de las columnas.
		_column_key RECORD; 	-- Variable para el FOR guarda los PK de las columnas.
		_session TEXT;	-- Almacena el usuario que genera el cambio.
		_user_db TEXT;		-- Almacena el usuario de bd que genera la transaccion.
		_control INT;		-- Variabel de control par alas llaves primarias.
		_count_key INT = 0;	-- Cantidad de columnas pertenecientes al PK.
		_sql_insert TEXT;	-- Variable para la construcción del insert del json de forma dinamica.
		_sql_delete TEXT;	-- Variable para la construcción del delete del json de forma dinamica.
		_sql_update TEXT;	-- Variable para la construcción del update del json de forma dinamica.
		_new_data RECORD; 	-- Fila que representa los campos nuevos del registro.
		_old_data RECORD;	-- Fila que representa los campos viejos del registro.

	BEGIN

			-- Se genera la evaluacion para determianr el tipo de accion sobre la tabla
		 IF (TG_OP = 'INSERT') THEN
			_new_data := NEW;
			_old_data := NEW;
		ELSEIF (TG_OP = 'UPDATE') THEN
			_new_data := NEW;
			_old_data := OLD;
		ELSE
			_new_data := OLD;
			_old_data := OLD;
		END IF;

		-- Se genera la evaluacion para determianr el tipo de accion sobre la tabla
		IF ((SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = TG_TABLE_SCHEMA AND table_name = TG_TABLE_NAME AND column_name = 'id' ) > 0) THEN
			_pk := _new_data.id;
		ELSE
			_pk := '-1';
		END IF;

		-- Se valida que exista el campo modified_by
		IF ((SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = TG_TABLE_SCHEMA AND table_name = TG_TABLE_NAME AND column_name = 'session') > 0) THEN
			_session := _new_data.session;
		ELSE
			_session := '';
		END IF;

		-- Se guarda el susuario de bd que genera la transaccion
		_user_db := (SELECT CURRENT_USER);

		-- Se evalua que exista el procedimeinto adecuado
		IF (SELECT COUNT(*) FROM security.function_db_view acfdv WHERE acfdv.b_function = 'field_audit' AND acfdv.b_type_parameters = TG_TABLE_SCHEMA || '.'|| TG_TABLE_NAME || ', '|| TG_TABLE_SCHEMA || '.'|| TG_TABLE_NAME || ', character varying, character varying, character varying, text, character varying, text, text') > 0
			THEN
				-- Se realiza la invocación del procedured generado dinamivamente
				PERFORM security.field_audit(_new_data, _old_data, TG_OP, _session, _user_db , _pk, ''::text);
		ELSE
			-- Se empieza la construcción del Procedured generico
			_sql := 'CREATE OR REPLACE FUNCTION security.field_audit( _data_new '|| TG_TABLE_SCHEMA || '.'|| TG_TABLE_NAME || ', _data_old '|| TG_TABLE_SCHEMA || '.'|| TG_TABLE_NAME || ', _accion character varying, _session text, _user_db character varying, _table_pk text, _init text)'
			|| ' RETURNS TEXT AS ''
'
			|| '
'
	|| '	DECLARE
'
	|| '		_column_data TEXT;
	 	_datos jsonb;
	 	
'
	|| '	BEGIN
			_datos = ''''{}'''';
';
			-- Se evalua si hay que actualizar la pk del registro de auditoria.
			IF _pk = '-1'
				THEN
					_sql := _sql
					|| '
		_column_data := ';

					-- Se genera el update con la clave pk de la tabla
					SELECT
						COUNT(isk.column_name)
					INTO
						_control
					FROM
						information_schema.table_constraints istc JOIN information_schema.key_column_usage isk ON isk.constraint_name = istc.constraint_name
					WHERE
						istc.table_schema = TG_TABLE_SCHEMA
					 AND	istc.table_name = TG_TABLE_NAME
					 AND	istc.constraint_type ilike '%primary%';

					-- Se agregan las columnas que componen la pk de la tabla.
					FOR _column_key IN SELECT
							isk.column_name
						FROM
							information_schema.table_constraints istc JOIN information_schema.key_column_usage isk ON isk.constraint_name = istc.constraint_name
						WHERE
							istc.table_schema = TG_TABLE_SCHEMA
						 AND	istc.table_name = TG_TABLE_NAME
						 AND	istc.constraint_type ilike '%primary%'
						ORDER BY 
							isk.ordinal_position  LOOP

						_sql := _sql || ' _data_new.' || _column_key.column_name;
						
						_count_key := _count_key + 1 ;
						
						IF _count_key < _control THEN
							_sql :=	_sql || ' || ' || ''''',''''' || ' ||';
						END IF;
					END LOOP;
				_sql := _sql || ';';
			END IF;

			_sql_insert:='
		IF _accion = ''''INSERT''''
			THEN
				';
			_sql_delete:='
		ELSEIF _accion = ''''DELETE''''
			THEN
				';
			_sql_update:='
		ELSE
			';

			-- Se genera el ciclo de agregado de columnas para el nuevo procedured
			FOR _column_guia IN SELECT column_name, data_type FROM information_schema.columns WHERE table_schema = TG_TABLE_SCHEMA AND table_name = TG_TABLE_NAME
				LOOP
						
					_sql_insert:= _sql_insert || '_datos := _datos || json_build_object('''''
					|| _column_guia.column_name
					|| '_nuevo'
					|| ''''', '
					|| '_data_new.'
					|| _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea', 'USER-DEFINED') THEN 
						_sql_insert:= _sql_insert
						||'::text';
					END IF;

					_sql_insert:= _sql_insert || ')::jsonb;
				';

					_sql_delete := _sql_delete || '_datos := _datos || json_build_object('''''
					|| _column_guia.column_name
					|| '_anterior'
					|| ''''', '
					|| '_data_old.'
					|| _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea', 'USER-DEFINED') THEN 
						_sql_delete:= _sql_delete
						||'::text';
					END IF;

					_sql_delete:= _sql_delete || ')::jsonb;
				';

					_sql_update := _sql_update || 'IF _data_old.' || _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea','USER-DEFINED') THEN 
						_sql_update:= _sql_update
						||'::text';
					END IF;

					_sql_update:= _sql_update || ' <> _data_new.' || _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea','USER-DEFINED') THEN 
						_sql_update:= _sql_update
						||'::text';
					END IF;

					_sql_update:= _sql_update || '
				THEN _datos := _datos || json_build_object('''''
					|| _column_guia.column_name
					|| '_anterior'
					|| ''''', '
					|| '_data_old.'
					|| _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea','USER-DEFINED') THEN 
						_sql_update:= _sql_update
						||'::text';
					END IF;

					_sql_update:= _sql_update
					|| ', '''''
					|| _column_guia.column_name
					|| '_nuevo'
					|| ''''', _data_new.'
					|| _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea', 'USER-DEFINED') THEN 
						_sql_update:= _sql_update
						||'::text';
					END IF;

					_sql_update:= _sql_update
					|| ')::jsonb;
			END IF;
			';
			END LOOP;

			-- Se le agrega la parte final del procedured generico
			
			_sql:= _sql || _sql_insert || _sql_delete || _sql_update
			|| ' 
		END IF;

		INSERT INTO security.auditoria
		(
			fecha,
			accion,
			schema,
			tabla,
			pk,
			session,
			user_bd,
			data
		)
		VALUES
		(
			CURRENT_TIMESTAMP,
			_accion,
			''''' || TG_TABLE_SCHEMA || ''''',
			''''' || TG_TABLE_NAME || ''''',
			_table_pk,
			_session,
			_user_db,
			_datos::jsonb
			);

		RETURN NULL; 
	END;'''
|| '
LANGUAGE plpgsql;';

			-- Se genera la ejecución de _sql, es decir se crea el nuevo procedured de forma generica.
			EXECUTE _sql;

		-- Se realiza la invocación del procedured generado dinamivamente
			PERFORM security.field_audit(_new_data, _old_data, TG_OP::character varying, _session, _user_db, _pk, ''::text);

		END IF;

		RETURN NULL;

END;
$$;


ALTER FUNCTION security.f_log_auditoria() OWNER TO postgres;

--
-- Name: autenticate_view; Type: VIEW; Schema: security; Owner: postgres
--

CREATE VIEW security.autenticate_view AS
 SELECT 0 AS user_id,
    ''::character varying(100) AS nombre,
    0 AS rol_id,
    ''::text AS rol_name;


ALTER TABLE security.autenticate_view OWNER TO postgres;

--
-- Name: f_loggin(text, text); Type: FUNCTION; Schema: security; Owner: postgres
--

CREATE FUNCTION security.f_loggin(_usuario text, _clave text) RETURNS SETOF security.autenticate_view
    LANGUAGE plpgsql
    AS $$
	DECLARE
		_user_id INTEGER;
		_nombre CHARACTER VARYING(100);
		_rol_id integer;
		_rol_nombre text;

	BEGIN

		IF (SELECT COUNT(*) FROM usuarios.usuarios WHERE usuario = _usuario AND clave = _clave ) > 0
			THEN
				SELECT
					uu.id_usuario,
					uu.nombre,
					ur.id_rol,
					ur.nombre_rol
				INTO
					_user_id,
					_nombre,
					_rol_id,
					_rol_nombre
				FROM
					usuarios.usuarios uu JOIN usuarios.roles ur ON ur.id_rol = uu.rol_id
				WHERE
					uu.usuario = _usuario AND uu.clave = _clave;
				 				
				RETURN QUERY 
					SELECT
						_user_id,
						_nombre,
						_rol_id,
						_rol_nombre;
		ELSE
			RETURN QUERY
				SELECT
					-1::INTEGER,
					''::CHARACTER VARYING(100),
					-1:: INTEGER,
					''::TEXT;
		END IF;
		
	END

$$;


ALTER FUNCTION security.f_loggin(_usuario text, _clave text) OWNER TO postgres;

--
-- Name: f_actualizar_servicio(integer, text, integer, text); Type: FUNCTION; Schema: servicios; Owner: postgres
--

CREATE FUNCTION servicios.f_actualizar_servicio(_id_ser integer, _nom_ser text, _costo integer, _tiempo text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
BEGIN

	UPDATE
		servicios.servicio
	SET
		id_ser = _id_ser,
		nom_ser = _nom_ser,
		costo = _costo,
		tiempo = _tiempo

	WHERE
		id_ser = _id_ser;

END
$$;


ALTER FUNCTION servicios.f_actualizar_servicio(_id_ser integer, _nom_ser text, _costo integer, _tiempo text) OWNER TO postgres;

--
-- Name: f_eliminar_servicio(integer); Type: FUNCTION; Schema: servicios; Owner: postgres
--

CREATE FUNCTION servicios.f_eliminar_servicio(_id_ser integer) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
BEGIN
	DELETE FROM servicios.servicio WHERE id_ser = _id_ser;
END
$$;


ALTER FUNCTION servicios.f_eliminar_servicio(_id_ser integer) OWNER TO postgres;

--
-- Name: f_insertar_servicio(text, integer, text, text, text); Type: FUNCTION; Schema: servicios; Owner: postgres
--

CREATE FUNCTION servicios.f_insertar_servicio(_nom_ser text, _costo integer, _tiempo text, _f_servicio text, _descripcion text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
BEGIN

	INSERT INTO servicios.servicio
	(
		nom_ser,
		costo,
		tiempo,
		f_servicio,
		descripcion
	)
	VALUES 
	(
		_nom_ser,
		_costo,
		_tiempo,
		_f_servicio,
		_descripcion
	);

END
$$;


ALTER FUNCTION servicios.f_insertar_servicio(_nom_ser text, _costo integer, _tiempo text, _f_servicio text, _descripcion text) OWNER TO postgres;

--
-- Name: f_insertar_serviciof(text, text); Type: FUNCTION; Schema: servicios; Owner: postgres
--

CREATE FUNCTION servicios.f_insertar_serviciof(_nom_ser text, _f_servicio text) RETURNS SETOF void
    LANGUAGE plpgsql
    AS $$
BEGIN

	INSERT INTO servicios.prueba
	(
		nom_ser,
		f_servicio
	)
	VALUES 
	(
		_nom_ser,
		_f_servicio
	);

END
$$;


ALTER FUNCTION servicios.f_insertar_serviciof(_nom_ser text, _f_servicio text) OWNER TO postgres;

--
-- Name: v_servicios; Type: VIEW; Schema: servicios; Owner: postgres
--

CREATE VIEW servicios.v_servicios WITH (security_barrier='false') AS
 SELECT 0 AS servicio_id,
    ''::text AS servicio_nom,
    0 AS costo,
    ''::text AS tiempo,
    ''::text AS servicio_f,
    ''::text AS servicio_des;


ALTER TABLE servicios.v_servicios OWNER TO postgres;

--
-- Name: f_obtener_asignars(); Type: FUNCTION; Schema: servicios; Owner: postgres
--

CREATE FUNCTION servicios.f_obtener_asignars() RETURNS SETOF servicios.v_servicios
    LANGUAGE plpgsql
    AS $$
BEGIN

		RETURN QUERY
		SELECT nom_ser
		FROM
			servicios.servicio;
END
$$;


ALTER FUNCTION servicios.f_obtener_asignars() OWNER TO postgres;

--
-- Name: v_fotoss; Type: VIEW; Schema: servicios; Owner: postgres
--

CREATE VIEW servicios.v_fotoss AS
 SELECT 0 AS servicio_id,
    ''::text AS servicio_nom,
    ''::text AS foto;


ALTER TABLE servicios.v_fotoss OWNER TO postgres;

--
-- Name: f_obtener_fotos(); Type: FUNCTION; Schema: servicios; Owner: postgres
--

CREATE FUNCTION servicios.f_obtener_fotos() RETURNS SETOF servicios.v_fotoss
    LANGUAGE plpgsql
    AS $$

		begin
        		return query 
                	select 
                    	cc.nom_ser,
                        cc.f_servicio
                     from 
                     	servicios.prueba;
        end 
$$;


ALTER FUNCTION servicios.f_obtener_fotos() OWNER TO postgres;

--
-- Name: f_obtener_servicio(); Type: FUNCTION; Schema: servicios; Owner: postgres
--

CREATE FUNCTION servicios.f_obtener_servicio() RETURNS SETOF servicios.v_servicios
    LANGUAGE plpgsql
    AS $$
BEGIN

		RETURN QUERY
		SELECT *
		FROM
			servicios.servicio;
END
$$;


ALTER FUNCTION servicios.f_obtener_servicio() OWNER TO postgres;

--
-- Name: f_insertar_usuarios(text, text, integer, text, text, text, integer, text, text); Type: FUNCTION; Schema: usuarios; Owner: postgres
--

CREATE FUNCTION usuarios.f_insertar_usuarios(_nombre text, _apellido text, _numero_identificacion integer, _correo text, _usuario text, _clave text, _rol_id integer, _session text, _tipo_identificacion text) RETURNS SETOF boolean
    LANGUAGE plpgsql
    AS $$
	BEGIN
		
		IF
			(SELECT COUNT (*) FROM usuarios.usuarios 
			WHERE (usuario = _usuario )) = 0
			THEN
				INSERT INTO usuarios.usuarios(
					--columnas de las tablas
				nombre,
				apellido,				
				numero_identificacion,
				correo,
				usuario,
				clave,
				rol_id,
				session,
				tipo_identificacion,
				create_date
				)
				VALUES 
				(
					--datos de entrada de visual
				_nombre,
				_apellido,					
				_numero_identificacion,
				_correo,
				_usuario,
				_clave,
				_rol_id,
				_session,				
				_tipo_identificacion,
				current_timestamp
				);
				
				RETURN QUERY
				SELECT true;
				
		ELSE
				RETURN QUERY
				SELECT false;
		END IF;
END
$$;


ALTER FUNCTION usuarios.f_insertar_usuarios(_nombre text, _apellido text, _numero_identificacion integer, _correo text, _usuario text, _clave text, _rol_id integer, _session text, _tipo_identificacion text) OWNER TO postgres;

--
-- Name: v_login; Type: VIEW; Schema: usuarios; Owner: postgres
--

CREATE VIEW usuarios.v_login AS
 SELECT 0 AS id_usuario,
    ''::text AS nombre,
    0 AS rol_id,
    ''::text AS rol_nombre;


ALTER TABLE usuarios.v_login OWNER TO postgres;

--
-- Name: f_login(text, text); Type: FUNCTION; Schema: usuarios; Owner: postgres
--

CREATE FUNCTION usuarios.f_login(_usuario text, _clave text) RETURNS SETOF usuarios.v_login
    LANGUAGE plpgsql
    AS $$
		BEGIN
			RETURN QUERY
			SELECT
				uu.id_usuario AS id_usuario,
				uu.nombre AS nombre,
				ur.id_rol AS rol_id,
				ur.nombre_rol AS rol_nombre

			FROM
				usuarios.usuarios uu JOIN usuarios.roles ur ON ur.id_rol = uu.rol_id
			WHERE
				uu.usuario = _usuario
			AND
				uu.clave = _clave;
		END;
	$$;


ALTER FUNCTION usuarios.f_login(_usuario text, _clave text) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: usuarios; Type: TABLE; Schema: usuarios; Owner: postgres
--

CREATE TABLE usuarios.usuarios (
    id_usuario integer NOT NULL,
    nombre text NOT NULL,
    apellido text NOT NULL,
    numero_identificacion integer NOT NULL,
    correo text NOT NULL,
    usuario text NOT NULL,
    clave text NOT NULL,
    rol_id integer NOT NULL,
    session text,
    tipo_identificacion text NOT NULL,
    create_date timestamp without time zone
);


ALTER TABLE usuarios.usuarios OWNER TO postgres;

--
-- Name: f_obtener_usuarios(text); Type: FUNCTION; Schema: usuarios; Owner: postgres
--

CREATE FUNCTION usuarios.f_obtener_usuarios(_filtro text) RETURNS SETOF usuarios.usuarios
    LANGUAGE plpgsql
    AS $$
	
	BEGIN
		RETURN QUERY
			SELECT
				*
			FROM
				usuarios.usuarios
			WHERE
				nombre ilike '%' || _filtro || '%';
			
	END

$$;


ALTER FUNCTION usuarios.f_obtener_usuarios(_filtro text) OWNER TO postgres;

--
-- Name: agenda; Type: TABLE; Schema: proyecto1; Owner: postgres
--

CREATE TABLE proyecto1.agenda (
    id_agenda integer NOT NULL,
    empleado_id integer NOT NULL,
    cliente_id integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    servicio_id integer NOT NULL,
    precio integer NOT NULL,
    estado_id integer NOT NULL,
    comentarios_emp text NOT NULL,
    comentarios_cli text NOT NULL
);


ALTER TABLE proyecto1.agenda OWNER TO postgres;

--
-- Name: agenda_id_agenda_seq; Type: SEQUENCE; Schema: proyecto1; Owner: postgres
--

CREATE SEQUENCE proyecto1.agenda_id_agenda_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proyecto1.agenda_id_agenda_seq OWNER TO postgres;

--
-- Name: agenda_id_agenda_seq; Type: SEQUENCE OWNED BY; Schema: proyecto1; Owner: postgres
--

ALTER SEQUENCE proyecto1.agenda_id_agenda_seq OWNED BY proyecto1.agenda.id_agenda;


--
-- Name: emp_serv; Type: TABLE; Schema: proyecto1; Owner: postgres
--

CREATE TABLE proyecto1.emp_serv (
    id_empser integer NOT NULL,
    empleado_id integer NOT NULL,
    servicio_id integer NOT NULL
);


ALTER TABLE proyecto1.emp_serv OWNER TO postgres;

--
-- Name: emp_serv_id_empser_seq; Type: SEQUENCE; Schema: proyecto1; Owner: postgres
--

CREATE SEQUENCE proyecto1.emp_serv_id_empser_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proyecto1.emp_serv_id_empser_seq OWNER TO postgres;

--
-- Name: emp_serv_id_empser_seq; Type: SEQUENCE OWNED BY; Schema: proyecto1; Owner: postgres
--

ALTER SEQUENCE proyecto1.emp_serv_id_empser_seq OWNED BY proyecto1.emp_serv.id_empser;


--
-- Name: estado_ser; Type: TABLE; Schema: proyecto1; Owner: postgres
--

CREATE TABLE proyecto1.estado_ser (
    id_estado integer NOT NULL,
    nom_est text NOT NULL
);


ALTER TABLE proyecto1.estado_ser OWNER TO postgres;

--
-- Name: estado_ser_id_estado_seq; Type: SEQUENCE; Schema: proyecto1; Owner: postgres
--

CREATE SEQUENCE proyecto1.estado_ser_id_estado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proyecto1.estado_ser_id_estado_seq OWNER TO postgres;

--
-- Name: estado_ser_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: proyecto1; Owner: postgres
--

ALTER SEQUENCE proyecto1.estado_ser_id_estado_seq OWNED BY proyecto1.estado_ser.id_estado;


--
-- Name: horario; Type: TABLE; Schema: proyecto1; Owner: postgres
--

CREATE TABLE proyecto1.horario (
    id_horario integer NOT NULL,
    empleado_id integer NOT NULL,
    horario date NOT NULL
);


ALTER TABLE proyecto1.horario OWNER TO postgres;

--
-- Name: horario_id_horario_seq; Type: SEQUENCE; Schema: proyecto1; Owner: postgres
--

CREATE SEQUENCE proyecto1.horario_id_horario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proyecto1.horario_id_horario_seq OWNER TO postgres;

--
-- Name: horario_id_horario_seq; Type: SEQUENCE OWNED BY; Schema: proyecto1; Owner: postgres
--

ALTER SEQUENCE proyecto1.horario_id_horario_seq OWNED BY proyecto1.horario.id_horario;


--
-- Name: rol; Type: TABLE; Schema: proyecto1; Owner: postgres
--

CREATE TABLE proyecto1.rol (
    id_rol integer NOT NULL,
    nom_rol text NOT NULL
);


ALTER TABLE proyecto1.rol OWNER TO postgres;

--
-- Name: rol_id_rol_seq; Type: SEQUENCE; Schema: proyecto1; Owner: postgres
--

CREATE SEQUENCE proyecto1.rol_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proyecto1.rol_id_rol_seq OWNER TO postgres;

--
-- Name: rol_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: proyecto1; Owner: postgres
--

ALTER SEQUENCE proyecto1.rol_id_rol_seq OWNED BY proyecto1.rol.id_rol;


--
-- Name: servicio; Type: TABLE; Schema: proyecto1; Owner: postgres
--

CREATE TABLE proyecto1.servicio (
    id_ser integer NOT NULL,
    nom_ser text NOT NULL,
    costo integer NOT NULL,
    tiempo text NOT NULL
);


ALTER TABLE proyecto1.servicio OWNER TO postgres;

--
-- Name: servicio_id_ser_seq; Type: SEQUENCE; Schema: proyecto1; Owner: postgres
--

CREATE SEQUENCE proyecto1.servicio_id_ser_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proyecto1.servicio_id_ser_seq OWNER TO postgres;

--
-- Name: servicio_id_ser_seq; Type: SEQUENCE OWNED BY; Schema: proyecto1; Owner: postgres
--

ALTER SEQUENCE proyecto1.servicio_id_ser_seq OWNED BY proyecto1.servicio.id_ser;


--
-- Name: usuarios; Type: TABLE; Schema: proyecto1; Owner: postgres
--

CREATE TABLE proyecto1.usuarios (
    id_usuario integer NOT NULL,
    nombre text NOT NULL,
    cedula integer NOT NULL,
    correo text NOT NULL,
    usuario text NOT NULL,
    clave text NOT NULL,
    rol_id integer NOT NULL
);


ALTER TABLE proyecto1.usuarios OWNER TO postgres;

--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: proyecto1; Owner: postgres
--

CREATE SEQUENCE proyecto1.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proyecto1.usuarios_id_usuario_seq OWNER TO postgres;

--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: proyecto1; Owner: postgres
--

ALTER SEQUENCE proyecto1.usuarios_id_usuario_seq OWNED BY proyecto1.usuarios.id_usuario;


--
-- Name: v_servicios; Type: VIEW; Schema: proyecto1; Owner: postgres
--

CREATE VIEW proyecto1.v_servicios AS
 SELECT 0 AS id_ser,
    ''::text AS nom_ser,
    0 AS costo,
    ''::text AS tiempo;


ALTER TABLE proyecto1.v_servicios OWNER TO postgres;

--
-- Name: auditoria; Type: TABLE; Schema: security; Owner: postgres
--

CREATE TABLE security.auditoria (
    id bigint NOT NULL,
    fecha timestamp without time zone NOT NULL,
    accion character varying(100),
    schema character varying(200) NOT NULL,
    tabla character varying(200),
    session text NOT NULL,
    user_bd character varying(100) NOT NULL,
    data jsonb NOT NULL,
    pk text NOT NULL
);


ALTER TABLE security.auditoria OWNER TO postgres;

--
-- Name: TABLE auditoria; Type: COMMENT; Schema: security; Owner: postgres
--

COMMENT ON TABLE security.auditoria IS 'Tabla que almacena la trazabilidad de la informaicón.';


--
-- Name: COLUMN auditoria.id; Type: COMMENT; Schema: security; Owner: postgres
--

COMMENT ON COLUMN security.auditoria.id IS 'campo pk de la tabla ';


--
-- Name: COLUMN auditoria.fecha; Type: COMMENT; Schema: security; Owner: postgres
--

COMMENT ON COLUMN security.auditoria.fecha IS 'ALmacen ala la fecha de la modificación';


--
-- Name: COLUMN auditoria.accion; Type: COMMENT; Schema: security; Owner: postgres
--

COMMENT ON COLUMN security.auditoria.accion IS 'Almacena la accion que se ejecuto sobre el registro';


--
-- Name: COLUMN auditoria.schema; Type: COMMENT; Schema: security; Owner: postgres
--

COMMENT ON COLUMN security.auditoria.schema IS 'Almanena el nomnbre del schema de la tabla que se modifico';


--
-- Name: COLUMN auditoria.tabla; Type: COMMENT; Schema: security; Owner: postgres
--

COMMENT ON COLUMN security.auditoria.tabla IS 'Almacena el nombre de la tabla que se modifico';


--
-- Name: COLUMN auditoria.session; Type: COMMENT; Schema: security; Owner: postgres
--

COMMENT ON COLUMN security.auditoria.session IS 'Campo que almacena el id de la session que generó el cambio';


--
-- Name: COLUMN auditoria.user_bd; Type: COMMENT; Schema: security; Owner: postgres
--

COMMENT ON COLUMN security.auditoria.user_bd IS 'Campo que almacena el user que se autentico en el motor para generar el cmabio';


--
-- Name: COLUMN auditoria.data; Type: COMMENT; Schema: security; Owner: postgres
--

COMMENT ON COLUMN security.auditoria.data IS 'campo que almacena la modificaicón que se realizó';


--
-- Name: COLUMN auditoria.pk; Type: COMMENT; Schema: security; Owner: postgres
--

COMMENT ON COLUMN security.auditoria.pk IS 'Campo que identifica el id del registro.';


--
-- Name: auditoria_id_seq; Type: SEQUENCE; Schema: security; Owner: postgres
--

CREATE SEQUENCE security.auditoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE security.auditoria_id_seq OWNER TO postgres;

--
-- Name: auditoria_id_seq; Type: SEQUENCE OWNED BY; Schema: security; Owner: postgres
--

ALTER SEQUENCE security.auditoria_id_seq OWNED BY security.auditoria.id;


--
-- Name: autenication; Type: TABLE; Schema: security; Owner: postgres
--

CREATE TABLE security.autenication (
    id bigint NOT NULL,
    user_id integer,
    ip character varying(100),
    mac character varying(100),
    fecha_inicio timestamp without time zone,
    session text,
    fecha_fin timestamp without time zone
);


ALTER TABLE security.autenication OWNER TO postgres;

--
-- Name: TABLE autenication; Type: COMMENT; Schema: security; Owner: postgres
--

COMMENT ON TABLE security.autenication IS 'Tabla que almacena las autenticaciones por parte de los usuarios.';


--
-- Name: COLUMN autenication.id; Type: COMMENT; Schema: security; Owner: postgres
--

COMMENT ON COLUMN security.autenication.id IS 'campo pk de la tabla';


--
-- Name: COLUMN autenication.user_id; Type: COMMENT; Schema: security; Owner: postgres
--

COMMENT ON COLUMN security.autenication.user_id IS 'Campo que identifica el usuario';


--
-- Name: COLUMN autenication.ip; Type: COMMENT; Schema: security; Owner: postgres
--

COMMENT ON COLUMN security.autenication.ip IS 'Cmapo que almacena la ip de la maquina.';


--
-- Name: COLUMN autenication.mac; Type: COMMENT; Schema: security; Owner: postgres
--

COMMENT ON COLUMN security.autenication.mac IS 'Campo que almacena la MAC del equipo.';


--
-- Name: COLUMN autenication.fecha_inicio; Type: COMMENT; Schema: security; Owner: postgres
--

COMMENT ON COLUMN security.autenication.fecha_inicio IS 'Captura la fecha de inicio de session';


--
-- Name: COLUMN autenication.session; Type: COMMENT; Schema: security; Owner: postgres
--

COMMENT ON COLUMN security.autenication.session IS 'Campo que almacena la session del usuario';


--
-- Name: COLUMN autenication.fecha_fin; Type: COMMENT; Schema: security; Owner: postgres
--

COMMENT ON COLUMN security.autenication.fecha_fin IS 'Cmapo que lamacena la feccha de cierre de session';


--
-- Name: autenication_id_seq; Type: SEQUENCE; Schema: security; Owner: postgres
--

CREATE SEQUENCE security.autenication_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE security.autenication_id_seq OWNER TO postgres;

--
-- Name: autenication_id_seq; Type: SEQUENCE OWNED BY; Schema: security; Owner: postgres
--

ALTER SEQUENCE security.autenication_id_seq OWNED BY security.autenication.id;


--
-- Name: function_db_view; Type: VIEW; Schema: security; Owner: postgres
--

CREATE VIEW security.function_db_view AS
 SELECT pp.proname AS b_function,
    oidvectortypes(pp.proargtypes) AS b_type_parameters
   FROM (pg_proc pp
     JOIN pg_namespace pn ON ((pn.oid = pp.pronamespace)))
  WHERE ((pn.nspname)::text <> ALL (ARRAY[('pg_catalog'::character varying)::text, ('information_schema'::character varying)::text, ('admin_control'::character varying)::text, ('vial'::character varying)::text]));


ALTER TABLE security.function_db_view OWNER TO postgres;

--
-- Name: prueba; Type: TABLE; Schema: servicios; Owner: postgres
--

CREATE TABLE servicios.prueba (
    id_ser integer NOT NULL,
    nom_ser text,
    f_servicio text
);


ALTER TABLE servicios.prueba OWNER TO postgres;

--
-- Name: prueba_id_ser_seq; Type: SEQUENCE; Schema: servicios; Owner: postgres
--

CREATE SEQUENCE servicios.prueba_id_ser_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE servicios.prueba_id_ser_seq OWNER TO postgres;

--
-- Name: prueba_id_ser_seq; Type: SEQUENCE OWNED BY; Schema: servicios; Owner: postgres
--

ALTER SEQUENCE servicios.prueba_id_ser_seq OWNED BY servicios.prueba.id_ser;


--
-- Name: servicio; Type: TABLE; Schema: servicios; Owner: postgres
--

CREATE TABLE servicios.servicio (
    id_ser integer NOT NULL,
    nom_ser text,
    costo integer,
    tiempo text,
    f_servicio text,
    descripcion text
);


ALTER TABLE servicios.servicio OWNER TO postgres;

--
-- Name: servicio_id_ser_seq; Type: SEQUENCE; Schema: servicios; Owner: postgres
--

CREATE SEQUENCE servicios.servicio_id_ser_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE servicios.servicio_id_ser_seq OWNER TO postgres;

--
-- Name: servicio_id_ser_seq; Type: SEQUENCE OWNED BY; Schema: servicios; Owner: postgres
--

ALTER SEQUENCE servicios.servicio_id_ser_seq OWNED BY servicios.servicio.id_ser;


--
-- Name: roles; Type: TABLE; Schema: usuarios; Owner: postgres
--

CREATE TABLE usuarios.roles (
    id_rol integer NOT NULL,
    nombre_rol text NOT NULL
);


ALTER TABLE usuarios.roles OWNER TO postgres;

--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: usuarios; Owner: postgres
--

CREATE SEQUENCE usuarios.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE usuarios.usuarios_id_usuario_seq OWNER TO postgres;

--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: usuarios; Owner: postgres
--

ALTER SEQUENCE usuarios.usuarios_id_usuario_seq OWNED BY usuarios.usuarios.id_usuario;


--
-- Name: agenda id_agenda; Type: DEFAULT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.agenda ALTER COLUMN id_agenda SET DEFAULT nextval('proyecto1.agenda_id_agenda_seq'::regclass);


--
-- Name: emp_serv id_empser; Type: DEFAULT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.emp_serv ALTER COLUMN id_empser SET DEFAULT nextval('proyecto1.emp_serv_id_empser_seq'::regclass);


--
-- Name: estado_ser id_estado; Type: DEFAULT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.estado_ser ALTER COLUMN id_estado SET DEFAULT nextval('proyecto1.estado_ser_id_estado_seq'::regclass);


--
-- Name: horario id_horario; Type: DEFAULT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.horario ALTER COLUMN id_horario SET DEFAULT nextval('proyecto1.horario_id_horario_seq'::regclass);


--
-- Name: rol id_rol; Type: DEFAULT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.rol ALTER COLUMN id_rol SET DEFAULT nextval('proyecto1.rol_id_rol_seq'::regclass);


--
-- Name: servicio id_ser; Type: DEFAULT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.servicio ALTER COLUMN id_ser SET DEFAULT nextval('proyecto1.servicio_id_ser_seq'::regclass);


--
-- Name: usuarios id_usuario; Type: DEFAULT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('proyecto1.usuarios_id_usuario_seq'::regclass);


--
-- Name: auditoria id; Type: DEFAULT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.auditoria ALTER COLUMN id SET DEFAULT nextval('security.auditoria_id_seq'::regclass);


--
-- Name: autenication id; Type: DEFAULT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.autenication ALTER COLUMN id SET DEFAULT nextval('security.autenication_id_seq'::regclass);


--
-- Name: prueba id_ser; Type: DEFAULT; Schema: servicios; Owner: postgres
--

ALTER TABLE ONLY servicios.prueba ALTER COLUMN id_ser SET DEFAULT nextval('servicios.prueba_id_ser_seq'::regclass);


--
-- Name: servicio id_ser; Type: DEFAULT; Schema: servicios; Owner: postgres
--

ALTER TABLE ONLY servicios.servicio ALTER COLUMN id_ser SET DEFAULT nextval('servicios.servicio_id_ser_seq'::regclass);


--
-- Name: usuarios id_usuario; Type: DEFAULT; Schema: usuarios; Owner: postgres
--

ALTER TABLE ONLY usuarios.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('usuarios.usuarios_id_usuario_seq'::regclass);


--
-- Data for Name: agenda; Type: TABLE DATA; Schema: proyecto1; Owner: postgres
--

COPY proyecto1.agenda (id_agenda, empleado_id, cliente_id, fecha_inicio, fecha_fin, servicio_id, precio, estado_id, comentarios_emp, comentarios_cli) FROM stdin;
\.
COPY proyecto1.agenda (id_agenda, empleado_id, cliente_id, fecha_inicio, fecha_fin, servicio_id, precio, estado_id, comentarios_emp, comentarios_cli) FROM '$$PATH$$/3008.dat';

--
-- Data for Name: emp_serv; Type: TABLE DATA; Schema: proyecto1; Owner: postgres
--

COPY proyecto1.emp_serv (id_empser, empleado_id, servicio_id) FROM stdin;
\.
COPY proyecto1.emp_serv (id_empser, empleado_id, servicio_id) FROM '$$PATH$$/3010.dat';

--
-- Data for Name: estado_ser; Type: TABLE DATA; Schema: proyecto1; Owner: postgres
--

COPY proyecto1.estado_ser (id_estado, nom_est) FROM stdin;
\.
COPY proyecto1.estado_ser (id_estado, nom_est) FROM '$$PATH$$/3012.dat';

--
-- Data for Name: horario; Type: TABLE DATA; Schema: proyecto1; Owner: postgres
--

COPY proyecto1.horario (id_horario, empleado_id, horario) FROM stdin;
\.
COPY proyecto1.horario (id_horario, empleado_id, horario) FROM '$$PATH$$/3006.dat';

--
-- Data for Name: rol; Type: TABLE DATA; Schema: proyecto1; Owner: postgres
--

COPY proyecto1.rol (id_rol, nom_rol) FROM stdin;
\.
COPY proyecto1.rol (id_rol, nom_rol) FROM '$$PATH$$/3002.dat';

--
-- Data for Name: servicio; Type: TABLE DATA; Schema: proyecto1; Owner: postgres
--

COPY proyecto1.servicio (id_ser, nom_ser, costo, tiempo) FROM stdin;
\.
COPY proyecto1.servicio (id_ser, nom_ser, costo, tiempo) FROM '$$PATH$$/3004.dat';

--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: proyecto1; Owner: postgres
--

COPY proyecto1.usuarios (id_usuario, nombre, cedula, correo, usuario, clave, rol_id) FROM stdin;
\.
COPY proyecto1.usuarios (id_usuario, nombre, cedula, correo, usuario, clave, rol_id) FROM '$$PATH$$/3014.dat';

--
-- Data for Name: auditoria; Type: TABLE DATA; Schema: security; Owner: postgres
--

COPY security.auditoria (id, fecha, accion, schema, tabla, session, user_bd, data, pk) FROM stdin;
\.
COPY security.auditoria (id, fecha, accion, schema, tabla, session, user_bd, data, pk) FROM '$$PATH$$/3018.dat';

--
-- Data for Name: autenication; Type: TABLE DATA; Schema: security; Owner: postgres
--

COPY security.autenication (id, user_id, ip, mac, fecha_inicio, session, fecha_fin) FROM stdin;
\.
COPY security.autenication (id, user_id, ip, mac, fecha_inicio, session, fecha_fin) FROM '$$PATH$$/3020.dat';

--
-- Data for Name: prueba; Type: TABLE DATA; Schema: servicios; Owner: postgres
--

COPY servicios.prueba (id_ser, nom_ser, f_servicio) FROM stdin;
\.
COPY servicios.prueba (id_ser, nom_ser, f_servicio) FROM '$$PATH$$/3025.dat';

--
-- Data for Name: servicio; Type: TABLE DATA; Schema: servicios; Owner: postgres
--

COPY servicios.servicio (id_ser, nom_ser, costo, tiempo, f_servicio, descripcion) FROM stdin;
\.
COPY servicios.servicio (id_ser, nom_ser, costo, tiempo, f_servicio, descripcion) FROM '$$PATH$$/3023.dat';

--
-- Data for Name: roles; Type: TABLE DATA; Schema: usuarios; Owner: postgres
--

COPY usuarios.roles (id_rol, nombre_rol) FROM stdin;
\.
COPY usuarios.roles (id_rol, nombre_rol) FROM '$$PATH$$/3015.dat';

--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: usuarios; Owner: postgres
--

COPY usuarios.usuarios (id_usuario, nombre, apellido, numero_identificacion, correo, usuario, clave, rol_id, session, tipo_identificacion, create_date) FROM stdin;
\.
COPY usuarios.usuarios (id_usuario, nombre, apellido, numero_identificacion, correo, usuario, clave, rol_id, session, tipo_identificacion, create_date) FROM '$$PATH$$/3016.dat';

--
-- Name: agenda_id_agenda_seq; Type: SEQUENCE SET; Schema: proyecto1; Owner: postgres
--

SELECT pg_catalog.setval('proyecto1.agenda_id_agenda_seq', 1, false);


--
-- Name: emp_serv_id_empser_seq; Type: SEQUENCE SET; Schema: proyecto1; Owner: postgres
--

SELECT pg_catalog.setval('proyecto1.emp_serv_id_empser_seq', 1, false);


--
-- Name: estado_ser_id_estado_seq; Type: SEQUENCE SET; Schema: proyecto1; Owner: postgres
--

SELECT pg_catalog.setval('proyecto1.estado_ser_id_estado_seq', 1, false);


--
-- Name: horario_id_horario_seq; Type: SEQUENCE SET; Schema: proyecto1; Owner: postgres
--

SELECT pg_catalog.setval('proyecto1.horario_id_horario_seq', 1, false);


--
-- Name: rol_id_rol_seq; Type: SEQUENCE SET; Schema: proyecto1; Owner: postgres
--

SELECT pg_catalog.setval('proyecto1.rol_id_rol_seq', 1, false);


--
-- Name: servicio_id_ser_seq; Type: SEQUENCE SET; Schema: proyecto1; Owner: postgres
--

SELECT pg_catalog.setval('proyecto1.servicio_id_ser_seq', 5, true);


--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: proyecto1; Owner: postgres
--

SELECT pg_catalog.setval('proyecto1.usuarios_id_usuario_seq', 6, true);


--
-- Name: auditoria_id_seq; Type: SEQUENCE SET; Schema: security; Owner: postgres
--

SELECT pg_catalog.setval('security.auditoria_id_seq', 34, true);


--
-- Name: autenication_id_seq; Type: SEQUENCE SET; Schema: security; Owner: postgres
--

SELECT pg_catalog.setval('security.autenication_id_seq', 56, true);


--
-- Name: prueba_id_ser_seq; Type: SEQUENCE SET; Schema: servicios; Owner: postgres
--

SELECT pg_catalog.setval('servicios.prueba_id_ser_seq', 1, true);


--
-- Name: servicio_id_ser_seq; Type: SEQUENCE SET; Schema: servicios; Owner: postgres
--

SELECT pg_catalog.setval('servicios.servicio_id_ser_seq', 6, true);


--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: usuarios; Owner: postgres
--

SELECT pg_catalog.setval('usuarios.usuarios_id_usuario_seq', 11, true);


--
-- Name: agenda pk_proyecto1_agenda; Type: CONSTRAINT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.agenda
    ADD CONSTRAINT pk_proyecto1_agenda PRIMARY KEY (id_agenda);


--
-- Name: emp_serv pk_proyecto1_empserv; Type: CONSTRAINT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.emp_serv
    ADD CONSTRAINT pk_proyecto1_empserv PRIMARY KEY (id_empser);


--
-- Name: estado_ser pk_proyecto1_estadoser; Type: CONSTRAINT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.estado_ser
    ADD CONSTRAINT pk_proyecto1_estadoser PRIMARY KEY (id_estado);


--
-- Name: horario pk_proyecto1_horario; Type: CONSTRAINT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.horario
    ADD CONSTRAINT pk_proyecto1_horario PRIMARY KEY (id_horario);


--
-- Name: rol pk_proyecto1_rol; Type: CONSTRAINT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.rol
    ADD CONSTRAINT pk_proyecto1_rol PRIMARY KEY (id_rol);


--
-- Name: servicio pk_proyecto1_servicio; Type: CONSTRAINT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.servicio
    ADD CONSTRAINT pk_proyecto1_servicio PRIMARY KEY (id_ser);


--
-- Name: usuarios pk_proyecto1_usuario; Type: CONSTRAINT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.usuarios
    ADD CONSTRAINT pk_proyecto1_usuario PRIMARY KEY (id_usuario);


--
-- Name: auditoria pk_security_auditoria; Type: CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.auditoria
    ADD CONSTRAINT pk_security_auditoria PRIMARY KEY (id);


--
-- Name: autenication pk_security_autenication; Type: CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.autenication
    ADD CONSTRAINT pk_security_autenication PRIMARY KEY (id);


--
-- Name: prueba pk_servicios_prueba; Type: CONSTRAINT; Schema: servicios; Owner: postgres
--

ALTER TABLE ONLY servicios.prueba
    ADD CONSTRAINT pk_servicios_prueba PRIMARY KEY (id_ser);


--
-- Name: servicio pk_servicios_servicio; Type: CONSTRAINT; Schema: servicios; Owner: postgres
--

ALTER TABLE ONLY servicios.servicio
    ADD CONSTRAINT pk_servicios_servicio PRIMARY KEY (id_ser);


--
-- Name: roles pk_usuarios_roles; Type: CONSTRAINT; Schema: usuarios; Owner: postgres
--

ALTER TABLE ONLY usuarios.roles
    ADD CONSTRAINT pk_usuarios_roles PRIMARY KEY (id_rol);


--
-- Name: usuarios pk_usuarios_usuarios; Type: CONSTRAINT; Schema: usuarios; Owner: postgres
--

ALTER TABLE ONLY usuarios.usuarios
    ADD CONSTRAINT pk_usuarios_usuarios PRIMARY KEY (id_usuario);


--
-- Name: usuarios u__nombre; Type: CONSTRAINT; Schema: usuarios; Owner: postgres
--

ALTER TABLE ONLY usuarios.usuarios
    ADD CONSTRAINT u__nombre UNIQUE (nombre);


--
-- Name: fki_agenda_estado; Type: INDEX; Schema: proyecto1; Owner: postgres
--

CREATE INDEX fki_agenda_estado ON proyecto1.agenda USING btree (estado_id);


--
-- Name: fki_agenda_servicio; Type: INDEX; Schema: proyecto1; Owner: postgres
--

CREATE INDEX fki_agenda_servicio ON proyecto1.agenda USING btree (servicio_id);


--
-- Name: fki_agenda_user; Type: INDEX; Schema: proyecto1; Owner: postgres
--

CREATE INDEX fki_agenda_user ON proyecto1.agenda USING btree (empleado_id);


--
-- Name: fki_agenda_usercli; Type: INDEX; Schema: proyecto1; Owner: postgres
--

CREATE INDEX fki_agenda_usercli ON proyecto1.agenda USING btree (cliente_id);


--
-- Name: fki_empser_user; Type: INDEX; Schema: proyecto1; Owner: postgres
--

CREATE INDEX fki_empser_user ON proyecto1.emp_serv USING btree (empleado_id);


--
-- Name: fki_horario_user; Type: INDEX; Schema: proyecto1; Owner: postgres
--

CREATE INDEX fki_horario_user ON proyecto1.horario USING btree (empleado_id);


--
-- Name: fki_usuario_rol; Type: INDEX; Schema: proyecto1; Owner: postgres
--

CREATE INDEX fki_usuario_rol ON proyecto1.usuarios USING btree (rol_id);


--
-- Name: fki_fk_usuarios_roles; Type: INDEX; Schema: usuarios; Owner: postgres
--

CREATE INDEX fki_fk_usuarios_roles ON usuarios.usuarios USING btree (rol_id);


--
-- Name: agenda agenda_estado; Type: FK CONSTRAINT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.agenda
    ADD CONSTRAINT agenda_estado FOREIGN KEY (estado_id) REFERENCES proyecto1.estado_ser(id_estado);


--
-- Name: agenda agenda_servicio; Type: FK CONSTRAINT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.agenda
    ADD CONSTRAINT agenda_servicio FOREIGN KEY (servicio_id) REFERENCES proyecto1.servicio(id_ser);


--
-- Name: agenda agenda_usercli; Type: FK CONSTRAINT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.agenda
    ADD CONSTRAINT agenda_usercli FOREIGN KEY (cliente_id) REFERENCES proyecto1.usuarios(id_usuario);


--
-- Name: agenda agenda_useremp; Type: FK CONSTRAINT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.agenda
    ADD CONSTRAINT agenda_useremp FOREIGN KEY (empleado_id) REFERENCES proyecto1.usuarios(id_usuario);


--
-- Name: emp_serv empser_user; Type: FK CONSTRAINT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.emp_serv
    ADD CONSTRAINT empser_user FOREIGN KEY (empleado_id) REFERENCES proyecto1.usuarios(id_usuario);


--
-- Name: horario horario_user; Type: FK CONSTRAINT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.horario
    ADD CONSTRAINT horario_user FOREIGN KEY (empleado_id) REFERENCES proyecto1.usuarios(id_usuario);


--
-- Name: usuarios usuario_rol; Type: FK CONSTRAINT; Schema: proyecto1; Owner: postgres
--

ALTER TABLE ONLY proyecto1.usuarios
    ADD CONSTRAINT usuario_rol FOREIGN KEY (rol_id) REFERENCES proyecto1.rol(id_rol);


--
-- Name: usuarios fk_usuarios_roles; Type: FK CONSTRAINT; Schema: usuarios; Owner: postgres
--

ALTER TABLE ONLY usuarios.usuarios
    ADD CONSTRAINT fk_usuarios_roles FOREIGN KEY (rol_id) REFERENCES usuarios.roles(id_rol);


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
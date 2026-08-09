SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict aKhTkVqAU3q4o4JbaMpPpm9CcQsWmfdCgQJ4Jyz4V4uN4z0GexmYSXKgO3DsePk

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES
	('00000000-0000-0000-0000-000000000000', '27336dc6-ac2e-437e-b9fc-2b5fed623f1f', 'authenticated', 'authenticated', 'markies@pos.ph', '$2a$10$6bZcRqUXGPEYcGkB8kOSdOIavhFsOrDlD4TSnWnafoVscp2IPU8AK', '2026-07-06 04:37:15.472503+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-07-07 15:07:17.312055+00', '{"role": "cashier", "provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2026-07-06 04:37:15.438841+00', '2026-07-08 03:52:04.188981+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', 'authenticated', 'authenticated', 'genuinepower123@gmail.com', '$2a$10$EhdMWpzj0pgsnH4LOPC.DOkqe.7lXtZg35QyTOyQV5gJEk5jYeLwy', '2026-07-05 14:10:56.42723+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-07-12 11:58:34.016017+00', '{"role": "admin", "provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2026-07-05 14:10:56.421286+00', '2026-07-12 11:58:34.018282+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '62fcac55-c64e-487d-8564-fc35c45f7907', 'authenticated', 'authenticated', 'mark@dev.com', '$2a$10$I6P49ORV7KNcwXdX/SF2zux7BbRlq2YF8tl2.i2NsK3h4TgRPlnd6', '2026-07-06 02:21:33.787526+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-07-06 03:08:37.806224+00', '{"role": "cashier", "provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2026-07-06 02:21:33.756433+00', '2026-07-06 03:08:37.813047+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'b964f700-6bf7-4e23-9186-d89b7345a86e', 'authenticated', 'authenticated', 'pepito@yourpos-internal.local', '$2a$10$hPnkF8U.aiRzoDHWEl02HOOcryIiepJyyHo1ZLDhCwAVcItBxuimq', '2026-07-06 03:09:24.555431+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"role": "cashier", "provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2026-07-06 03:09:24.54574+00', '2026-07-06 03:09:24.55633+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '{"sub": "78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7", "email": "genuinepower123@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2026-07-05 14:10:56.42545+00', '2026-07-05 14:10:56.425502+00', '2026-07-05 14:10:56.425502+00', '77a78f68-5870-4a03-83ca-89eb32d65b56'),
	('62fcac55-c64e-487d-8564-fc35c45f7907', '62fcac55-c64e-487d-8564-fc35c45f7907', '{"sub": "62fcac55-c64e-487d-8564-fc35c45f7907", "email": "mark@dev.com", "email_verified": false, "phone_verified": false}', 'email', '2026-07-06 02:21:33.779748+00', '2026-07-06 02:21:33.779808+00', '2026-07-06 02:21:33.779808+00', '774b7267-0fb4-49c3-ad0d-19d77fb8bb0b'),
	('b964f700-6bf7-4e23-9186-d89b7345a86e', 'b964f700-6bf7-4e23-9186-d89b7345a86e', '{"sub": "b964f700-6bf7-4e23-9186-d89b7345a86e", "email": "pepito@yourpos-internal.local", "email_verified": false, "phone_verified": false}', 'email', '2026-07-06 03:09:24.552741+00', '2026-07-06 03:09:24.552794+00', '2026-07-06 03:09:24.552794+00', 'b9d14b3f-616b-480b-8f6f-dbed95ecbe37'),
	('27336dc6-ac2e-437e-b9fc-2b5fed623f1f', '27336dc6-ac2e-437e-b9fc-2b5fed623f1f', '{"sub": "27336dc6-ac2e-437e-b9fc-2b5fed623f1f", "email": "markies@pos.ph", "email_verified": false, "phone_verified": false}', 'email', '2026-07-06 04:37:15.462837+00', '2026-07-06 04:37:15.462892+00', '2026-07-06 04:37:15.462892+00', '234ddef7-a193-4285-afd3-fe5a71bf64af');


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag", "oauth_client_id", "refresh_token_hmac_key", "refresh_token_counter", "scopes") VALUES
	('d9a9fd5e-82df-4ed3-aa99-df4b168cacd3', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-05 14:12:53.345468+00', '2026-07-05 14:12:53.345468+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('1e3bfcdb-74a7-45eb-b4c4-a749128d0dc5', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-05 14:23:05.507737+00', '2026-07-05 14:23:05.507737+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('663dfde6-2d75-47d3-abeb-ca6b4358e292', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-05 14:28:05.115361+00', '2026-07-05 14:28:05.115361+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('f381f904-36d9-444f-a063-c0d8ca12248a', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-05 14:28:06.955042+00', '2026-07-05 14:28:06.955042+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('22de82a0-ff4f-4187-9f4e-793a2889b4b6', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-05 14:28:08.497327+00', '2026-07-05 14:28:08.497327+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('c8f5cd1e-9e96-4131-872d-5dc133d4ed23', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-05 14:28:11.532663+00', '2026-07-05 14:28:11.532663+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('21730945-8cfc-482c-94fd-50adee9256d4', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-05 14:28:12.377736+00', '2026-07-05 14:28:12.377736+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('1bbce163-f226-46f5-8f6f-54bcf4eb0edd', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-05 14:28:13.607753+00', '2026-07-05 14:28:13.607753+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('936864e2-418a-4852-a675-4c78fd51ee60', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-05 14:28:15.498109+00', '2026-07-05 14:28:15.498109+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('0c38c224-23cb-4753-bc55-4da6e2b50960', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-05 14:28:17.202267+00', '2026-07-05 14:28:17.202267+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('8a95c576-5f30-4fe3-a21f-a40436d11ae3', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-05 14:28:20.841175+00', '2026-07-05 14:28:20.841175+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('75867655-0497-4882-8fe3-b516737b9e7b', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-05 14:28:21.393967+00', '2026-07-06 00:48:57.59795+00', NULL, 'aal1', NULL, '2026-07-06 00:48:57.597839', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('034b4348-0386-4834-983a-f904f528a813', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-06 00:49:05.375155+00', '2026-07-06 00:49:05.375155+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('75dd9862-4307-42e6-aa81-31e72fc3c768', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-06 00:49:59.28243+00', '2026-07-06 00:49:59.28243+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('930a3174-e9ad-4372-8d39-64df585c8022', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-06 00:50:20.697198+00', '2026-07-06 00:50:20.697198+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('17c61f3d-f3e9-44bf-a4ca-817a783da4f4', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-06 00:54:05.627243+00', '2026-07-06 00:54:05.627243+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('5fb9187b-b900-4051-9fa2-287ad3ede4ee', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-06 01:03:51.076904+00', '2026-07-06 01:03:51.076904+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('5e696e77-1934-4bed-8a6a-ce64c17f1bac', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-06 01:03:57.01391+00', '2026-07-06 01:03:57.01391+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('1ec18391-96c0-41d3-9823-3a5c87b7d75e', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-06 01:03:57.93009+00', '2026-07-06 01:03:57.93009+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('35994998-cbe5-44ce-8b96-66bfc8b1fc6e', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-06 01:23:32.378308+00', '2026-07-06 01:23:32.378308+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('9118abc3-e5b5-4c41-9366-eacc77e51af6', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-06 01:24:12.437517+00', '2026-07-06 01:24:12.437517+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('46961c59-d72c-4063-a9a6-e6810153383b', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-06 01:24:26.377972+00', '2026-07-06 01:24:26.377972+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('45a60508-17a3-4cfb-9738-62eaa5517caa', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-06 01:24:28.918335+00', '2026-07-06 01:24:28.918335+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('462f6e9a-ce17-4811-b500-eece7f80820f', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-06 01:24:31.443963+00', '2026-07-06 01:24:31.443963+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('ba89a12c-40ff-4c41-a043-eb5ff5c384c3', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-06 01:34:36.695517+00', '2026-07-06 01:34:36.695517+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('ed85383c-8163-4d46-9c07-85d16e54dba2', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-06 01:41:27.833506+00', '2026-07-06 01:41:27.833506+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('df5b16d4-32b9-4e1a-8014-8f3a3c5f05bf', '62fcac55-c64e-487d-8564-fc35c45f7907', '2026-07-06 02:33:07.369304+00', '2026-07-06 02:33:07.369304+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('0c8622b6-2fff-4f4f-b7b0-aa572fce03c9', '62fcac55-c64e-487d-8564-fc35c45f7907', '2026-07-06 02:33:25.203898+00', '2026-07-06 02:33:25.203898+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('207b25c1-30e2-4c81-96cd-264abc76bbbc', '62fcac55-c64e-487d-8564-fc35c45f7907', '2026-07-06 02:33:26.744195+00', '2026-07-06 02:33:26.744195+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('8716e2ad-a6b0-40d9-a21e-583e432e1b0e', '62fcac55-c64e-487d-8564-fc35c45f7907', '2026-07-06 02:33:28.77203+00', '2026-07-06 02:33:28.77203+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('45da9f9c-9061-4ccc-957a-f2a373e689e2', '62fcac55-c64e-487d-8564-fc35c45f7907', '2026-07-06 02:33:29.982422+00', '2026-07-06 02:33:29.982422+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('9eb11a89-349b-4c4e-aa63-b78342bfe88d', '62fcac55-c64e-487d-8564-fc35c45f7907', '2026-07-06 02:33:31.130145+00', '2026-07-06 02:33:31.130145+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('40dab799-2ea4-4fb3-b22e-85a1131ad2f4', '62fcac55-c64e-487d-8564-fc35c45f7907', '2026-07-06 03:01:39.948414+00', '2026-07-06 03:01:39.948414+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('9da87a08-35de-452e-9ec2-c2acb49da89c', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-06 03:04:47.766253+00', '2026-07-06 03:04:47.766253+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('321b1693-d907-48bd-935b-aadc403ea2b4', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-06 03:05:42.458324+00', '2026-07-06 03:05:42.458324+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('cb24c1fe-91b4-4b56-ae43-f599866827e4', '62fcac55-c64e-487d-8564-fc35c45f7907', '2026-07-06 03:05:50.777547+00', '2026-07-06 03:05:50.777547+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('3ab2e4f4-dbb1-4506-bca6-4ca26b99c213', '62fcac55-c64e-487d-8564-fc35c45f7907', '2026-07-06 03:08:37.806331+00', '2026-07-06 03:08:37.806331+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('83b7e0bb-28bd-4e87-a6c6-2bff3c0bcd16', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-12 11:50:29.385919+00', '2026-07-12 11:50:29.385919+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '13.212.162.76', NULL, NULL, NULL, NULL, NULL),
	('bec40fd5-eae0-4af3-a370-c09e1a691be4', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-12 11:58:30.48418+00', '2026-07-12 11:58:30.48418+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '13.125.73.230', NULL, NULL, NULL, NULL, NULL),
	('4e538703-0894-4020-8c71-0134b255fb56', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-12 11:58:34.016126+00', '2026-07-12 11:58:34.016126+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '15.165.158.103', NULL, NULL, NULL, NULL, NULL),
	('f9283fe1-9b28-42b5-8a49-e3d93761506b', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-06 03:09:08.856632+00', '2026-07-07 07:50:21.178987+00', NULL, 'aal1', NULL, '2026-07-07 07:50:21.178865', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('50915a79-afed-4138-951a-f25159d0bd6f', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-07 07:55:24.007601+00', '2026-07-07 14:55:54.696946+00', NULL, 'aal1', NULL, '2026-07-07 14:55:54.696833', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('67b9f745-5f4a-4405-8f76-bb1ecb828b81', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-07 14:56:07.053045+00', '2026-07-07 14:56:07.053045+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('78bc01e1-72b2-459b-82e7-7049f8477438', '27336dc6-ac2e-437e-b9fc-2b5fed623f1f', '2026-07-07 14:57:06.827942+00', '2026-07-07 14:57:06.827942+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('df054930-6600-41ed-a5fc-6fb00fda3bad', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-07 14:58:24.48348+00', '2026-07-07 14:58:24.48348+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('e0479285-2cd8-47b1-97e3-c195f865a457', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-07 14:58:36.724028+00', '2026-07-07 14:58:36.724028+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('a002b880-2a62-4104-9139-9820fac5d628', '27336dc6-ac2e-437e-b9fc-2b5fed623f1f', '2026-07-07 14:58:41.446211+00', '2026-07-07 14:58:41.446211+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('9efeb4bb-8f5a-46c1-9a9a-1569092d0f90', '27336dc6-ac2e-437e-b9fc-2b5fed623f1f', '2026-07-07 14:58:42.843823+00', '2026-07-07 14:58:42.843823+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('d8cf0217-c6d7-41c0-8a94-e6e99ad7d7ff', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-07 14:58:45.589762+00', '2026-07-07 14:58:45.589762+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('a7c79baa-7b95-4af3-a0b3-a50a0fd0d6a0', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-07 14:59:02.248374+00', '2026-07-07 14:59:02.248374+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('65edf444-ab3d-4cbd-93dd-7e96b4741ef5', '27336dc6-ac2e-437e-b9fc-2b5fed623f1f', '2026-07-07 15:07:06.776706+00', '2026-07-07 15:07:06.776706+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('502ac702-f510-4113-bd16-b7a6ccccb132', '27336dc6-ac2e-437e-b9fc-2b5fed623f1f', '2026-07-07 15:07:12.86951+00', '2026-07-07 15:07:12.86951+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('e29fba73-c1f4-4c96-860a-e7cea0106b2c', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-08 03:07:35.150205+00', '2026-07-08 03:07:35.150205+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '3.35.48.61', NULL, NULL, NULL, NULL, NULL),
	('4e67fbfe-bb01-4231-a63f-57bf70c12466', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-08 03:08:55.549716+00', '2026-07-08 03:08:55.549716+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '3.39.239.226', NULL, NULL, NULL, NULL, NULL),
	('ba27552d-780b-4746-b141-11940c59e53d', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-08 03:09:54.428958+00', '2026-07-08 03:09:54.428958+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '52.78.203.43', NULL, NULL, NULL, NULL, NULL),
	('5acb5fca-c31d-4177-b6f0-9281a971fa06', '27336dc6-ac2e-437e-b9fc-2b5fed623f1f', '2026-07-07 15:07:17.312157+00', '2026-07-08 03:52:04.204926+00', NULL, 'aal1', NULL, '2026-07-08 03:52:04.204813', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '136.158.11.170', NULL, NULL, NULL, NULL, NULL),
	('2fcfe560-bc04-4317-9921-b1ab8d7b7b1f', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-08 03:52:13.743801+00', '2026-07-08 03:52:13.743801+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '54.179.252.63', NULL, NULL, NULL, NULL, NULL),
	('6580a247-5e38-4d6c-95f3-ec31df690bb8', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-08 03:52:26.325354+00', '2026-07-08 03:52:26.325354+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '3.1.26.10', NULL, NULL, NULL, NULL, NULL),
	('6be14b93-f744-41cc-aef5-622e310706a5', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-10 09:28:44.985471+00', '2026-07-10 09:28:44.985471+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '3.36.86.241', NULL, NULL, NULL, NULL, NULL),
	('a42d95ee-81d3-401f-af4f-066a31581b52', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-10 10:11:05.226163+00', '2026-07-10 10:11:05.226163+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '13.124.27.21', NULL, NULL, NULL, NULL, NULL),
	('8716354e-6ace-4fee-9f86-74422a8542be', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-10 10:11:15.158967+00', '2026-07-10 10:11:15.158967+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '13.125.223.245', NULL, NULL, NULL, NULL, NULL),
	('7e6074a8-833c-4660-9e5f-150ea71d8757', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-10 11:36:24.590159+00', '2026-07-10 11:36:24.590159+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '13.229.139.24', NULL, NULL, NULL, NULL, NULL),
	('7d274838-1fd1-4f81-85b5-7a39ba4199e1', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-10 11:36:38.296459+00', '2026-07-10 11:36:38.296459+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '13.215.227.157', NULL, NULL, NULL, NULL, NULL),
	('a9731a5f-756f-47ea-818e-a1a064c59110', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-10 11:52:18.463076+00', '2026-07-10 11:52:18.463076+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '47.129.137.144', NULL, NULL, NULL, NULL, NULL),
	('0c0c3dfb-2e8d-4abd-b1bd-013b88d8c038', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-10 12:12:34.213706+00', '2026-07-10 12:12:34.213706+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '54.180.156.205', NULL, NULL, NULL, NULL, NULL),
	('4e1d4484-60d6-40ea-8936-d0529b120f32', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-10 13:32:04.747817+00', '2026-07-10 13:32:04.747817+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '13.214.170.215', NULL, NULL, NULL, NULL, NULL),
	('5cbb0087-0316-403d-8ad9-1fb722dd9ab9', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-12 10:09:43.255173+00', '2026-07-12 10:09:43.255173+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '52.79.46.203', NULL, NULL, NULL, NULL, NULL),
	('deda75d7-6e66-40b6-a565-53f44b5cb722', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-12 10:09:49.112539+00', '2026-07-12 10:09:49.112539+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '13.124.209.247', NULL, NULL, NULL, NULL, NULL),
	('62a79602-70d7-4108-9813-7f2a1d7b94d4', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-12 10:22:11.957686+00', '2026-07-12 10:22:11.957686+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '18.143.92.66', NULL, NULL, NULL, NULL, NULL),
	('4e71b538-829e-4400-b72f-0934d629a913', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', '2026-07-12 10:23:50.824739+00', '2026-07-12 10:23:50.824739+00', NULL, 'aal1', NULL, NULL, 'Deno/2.1.4 (variant; SupabaseEdgeRuntime/1.74.2)', '47.129.12.10', NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") VALUES
	('d9a9fd5e-82df-4ed3-aa99-df4b168cacd3', '2026-07-05 14:12:53.365262+00', '2026-07-05 14:12:53.365262+00', 'password', '96aa8937-448b-4cb3-857e-03d34edbdb97'),
	('1e3bfcdb-74a7-45eb-b4c4-a749128d0dc5', '2026-07-05 14:23:05.526593+00', '2026-07-05 14:23:05.526593+00', 'password', 'f8a1824f-3a1e-4268-83c0-2a6dbad02959'),
	('663dfde6-2d75-47d3-abeb-ca6b4358e292', '2026-07-05 14:28:05.128824+00', '2026-07-05 14:28:05.128824+00', 'password', '85486765-b859-4f76-8d6a-c225e8ed38f0'),
	('f381f904-36d9-444f-a063-c0d8ca12248a', '2026-07-05 14:28:06.957417+00', '2026-07-05 14:28:06.957417+00', 'password', '66396ec4-a59e-4a6e-9111-e946ba5496c3'),
	('22de82a0-ff4f-4187-9f4e-793a2889b4b6', '2026-07-05 14:28:08.499711+00', '2026-07-05 14:28:08.499711+00', 'password', 'baabb2e9-b436-4ff7-bb35-ed4393cca1fb'),
	('c8f5cd1e-9e96-4131-872d-5dc133d4ed23', '2026-07-05 14:28:11.535066+00', '2026-07-05 14:28:11.535066+00', 'password', 'e8e08a1a-6b05-4a8f-a587-d048606c88a5'),
	('21730945-8cfc-482c-94fd-50adee9256d4', '2026-07-05 14:28:12.380289+00', '2026-07-05 14:28:12.380289+00', 'password', 'ccee0bdb-c30a-402c-bfe8-57758cea2968'),
	('1bbce163-f226-46f5-8f6f-54bcf4eb0edd', '2026-07-05 14:28:13.610179+00', '2026-07-05 14:28:13.610179+00', 'password', '77b68c1f-7b83-476f-b3d8-7ddc313c9ff1'),
	('936864e2-418a-4852-a675-4c78fd51ee60', '2026-07-05 14:28:15.500364+00', '2026-07-05 14:28:15.500364+00', 'password', 'e7c3c53f-7c1e-49c6-a1c0-7b92d3c8a57e'),
	('0c38c224-23cb-4753-bc55-4da6e2b50960', '2026-07-05 14:28:17.204485+00', '2026-07-05 14:28:17.204485+00', 'password', 'b21364df-af42-4c88-89d3-b91a36d5f1e2'),
	('8a95c576-5f30-4fe3-a21f-a40436d11ae3', '2026-07-05 14:28:20.843583+00', '2026-07-05 14:28:20.843583+00', 'password', 'd875ee17-9c9c-4fc6-a0b1-f2080e278214'),
	('75867655-0497-4882-8fe3-b516737b9e7b', '2026-07-05 14:28:21.396195+00', '2026-07-05 14:28:21.396195+00', 'password', '3b379d06-6f20-4fca-91c1-984e6817c3a3'),
	('034b4348-0386-4834-983a-f904f528a813', '2026-07-06 00:49:05.385109+00', '2026-07-06 00:49:05.385109+00', 'password', 'e61da360-9616-484d-b3e9-fc9a57b5c0cc'),
	('75dd9862-4307-42e6-aa81-31e72fc3c768', '2026-07-06 00:49:59.298316+00', '2026-07-06 00:49:59.298316+00', 'password', '985d5849-04d6-4e6f-9303-aa85a5e1d328'),
	('930a3174-e9ad-4372-8d39-64df585c8022', '2026-07-06 00:50:20.699688+00', '2026-07-06 00:50:20.699688+00', 'password', '172943c3-3249-4710-a974-6ced266a9e7c'),
	('17c61f3d-f3e9-44bf-a4ca-817a783da4f4', '2026-07-06 00:54:05.64474+00', '2026-07-06 00:54:05.64474+00', 'password', '8efc119f-3119-4c51-aa36-2736a50dc4f6'),
	('5fb9187b-b900-4051-9fa2-287ad3ede4ee', '2026-07-06 01:03:51.089069+00', '2026-07-06 01:03:51.089069+00', 'password', 'd081fdbf-b965-44c3-a1f3-992b27370d56'),
	('5e696e77-1934-4bed-8a6a-ce64c17f1bac', '2026-07-06 01:03:57.016647+00', '2026-07-06 01:03:57.016647+00', 'password', 'e6aa39e4-7b54-426b-bd9f-93ccd98c08fd'),
	('1ec18391-96c0-41d3-9823-3a5c87b7d75e', '2026-07-06 01:03:57.93256+00', '2026-07-06 01:03:57.93256+00', 'password', 'e7d6b6dd-24c7-43b3-a3c8-642d754daf01'),
	('35994998-cbe5-44ce-8b96-66bfc8b1fc6e', '2026-07-06 01:23:32.406056+00', '2026-07-06 01:23:32.406056+00', 'password', '61dc4013-fce5-4f7e-85d7-a81266d195ba'),
	('9118abc3-e5b5-4c41-9366-eacc77e51af6', '2026-07-06 01:24:12.440593+00', '2026-07-06 01:24:12.440593+00', 'password', '72b24943-bfe3-4fb1-89e8-bc737ba895d4'),
	('46961c59-d72c-4063-a9a6-e6810153383b', '2026-07-06 01:24:26.380701+00', '2026-07-06 01:24:26.380701+00', 'password', '8c67867a-dd65-42d5-84f9-e0a615561c0e'),
	('45a60508-17a3-4cfb-9738-62eaa5517caa', '2026-07-06 01:24:28.920734+00', '2026-07-06 01:24:28.920734+00', 'password', '00ee36db-c2a6-4c39-b6cc-7b4db53830f6'),
	('462f6e9a-ce17-4811-b500-eece7f80820f', '2026-07-06 01:24:31.446372+00', '2026-07-06 01:24:31.446372+00', 'password', 'e5392501-a022-4f42-bf56-735038312558'),
	('ba89a12c-40ff-4c41-a043-eb5ff5c384c3', '2026-07-06 01:34:36.708772+00', '2026-07-06 01:34:36.708772+00', 'password', 'e18b9de2-d7a4-4923-b5a4-ae18bdcca861'),
	('ed85383c-8163-4d46-9c07-85d16e54dba2', '2026-07-06 01:41:27.850593+00', '2026-07-06 01:41:27.850593+00', 'password', '6a6dbdd3-65f0-40e8-9248-108995664350'),
	('df5b16d4-32b9-4e1a-8014-8f3a3c5f05bf', '2026-07-06 02:33:07.397495+00', '2026-07-06 02:33:07.397495+00', 'password', '912ee31f-d17f-44b8-8892-543f2ad822ee'),
	('0c8622b6-2fff-4f4f-b7b0-aa572fce03c9', '2026-07-06 02:33:25.206296+00', '2026-07-06 02:33:25.206296+00', 'password', '491bec39-000d-4bd8-ad87-225a17854802'),
	('207b25c1-30e2-4c81-96cd-264abc76bbbc', '2026-07-06 02:33:26.746776+00', '2026-07-06 02:33:26.746776+00', 'password', '3510907e-21dd-4e9d-b82d-ad35907b07cd'),
	('8716e2ad-a6b0-40d9-a21e-583e432e1b0e', '2026-07-06 02:33:28.775656+00', '2026-07-06 02:33:28.775656+00', 'password', '49406b79-909a-4e8e-8951-907ca0cb7fd8'),
	('45da9f9c-9061-4ccc-957a-f2a373e689e2', '2026-07-06 02:33:29.984921+00', '2026-07-06 02:33:29.984921+00', 'password', '094ab5b3-d0ac-4992-a367-201a91d56f62'),
	('9eb11a89-349b-4c4e-aa63-b78342bfe88d', '2026-07-06 02:33:31.132748+00', '2026-07-06 02:33:31.132748+00', 'password', '2074971f-8071-492a-bc57-4a810bb00e87'),
	('40dab799-2ea4-4fb3-b22e-85a1131ad2f4', '2026-07-06 03:01:39.984587+00', '2026-07-06 03:01:39.984587+00', 'password', 'aed9c7ea-fe72-4cdc-8ace-eaa99293d4af'),
	('9da87a08-35de-452e-9ec2-c2acb49da89c', '2026-07-06 03:04:47.784128+00', '2026-07-06 03:04:47.784128+00', 'password', '83c52c6d-268c-48bb-b16d-2d749913b96b'),
	('321b1693-d907-48bd-935b-aadc403ea2b4', '2026-07-06 03:05:42.465626+00', '2026-07-06 03:05:42.465626+00', 'password', 'dcab4b4c-cdc5-4d44-bd87-769258006f9a'),
	('cb24c1fe-91b4-4b56-ae43-f599866827e4', '2026-07-06 03:05:50.780333+00', '2026-07-06 03:05:50.780333+00', 'password', 'ddb1ab3c-a1ac-4612-a087-45ebaa8d090f'),
	('3ab2e4f4-dbb1-4506-bca6-4ca26b99c213', '2026-07-06 03:08:37.814028+00', '2026-07-06 03:08:37.814028+00', 'password', '4227f572-87a5-491a-9194-db63858c78c7'),
	('f9283fe1-9b28-42b5-8a49-e3d93761506b', '2026-07-06 03:09:08.866867+00', '2026-07-06 03:09:08.866867+00', 'password', '6fc43f2e-b385-49a9-9b92-f5174e0e93a7'),
	('50915a79-afed-4138-951a-f25159d0bd6f', '2026-07-07 07:55:24.023642+00', '2026-07-07 07:55:24.023642+00', 'password', 'bc33056c-8871-4038-8560-930a1a4ee393'),
	('67b9f745-5f4a-4405-8f76-bb1ecb828b81', '2026-07-07 14:56:07.061751+00', '2026-07-07 14:56:07.061751+00', 'password', '2abddbab-409c-429e-9fac-4a092ba58a7c'),
	('78bc01e1-72b2-459b-82e7-7049f8477438', '2026-07-07 14:57:06.831164+00', '2026-07-07 14:57:06.831164+00', 'password', 'b25a9ae7-1669-4dcc-aa4f-55d9311d1539'),
	('df054930-6600-41ed-a5fc-6fb00fda3bad', '2026-07-07 14:58:24.489901+00', '2026-07-07 14:58:24.489901+00', 'password', 'd8fa5d96-319d-43f6-99f8-68b88b5005a6'),
	('e0479285-2cd8-47b1-97e3-c195f865a457', '2026-07-07 14:58:36.726864+00', '2026-07-07 14:58:36.726864+00', 'password', '1cb43f95-0362-4b7d-be2a-03d1562176ba'),
	('a002b880-2a62-4104-9139-9820fac5d628', '2026-07-07 14:58:41.44888+00', '2026-07-07 14:58:41.44888+00', 'password', '410b6dae-d77b-43b8-abfd-2bd35752461a'),
	('9efeb4bb-8f5a-46c1-9a9a-1569092d0f90', '2026-07-07 14:58:42.846262+00', '2026-07-07 14:58:42.846262+00', 'password', '762f4684-26db-4691-b885-39f8400d17c9'),
	('d8cf0217-c6d7-41c0-8a94-e6e99ad7d7ff', '2026-07-07 14:58:45.59367+00', '2026-07-07 14:58:45.59367+00', 'password', 'c01788aa-5c7c-4aa1-885f-4eecb906f47f'),
	('a7c79baa-7b95-4af3-a0b3-a50a0fd0d6a0', '2026-07-07 14:59:02.252525+00', '2026-07-07 14:59:02.252525+00', 'password', '0b358de9-7a9e-42d2-8ae5-7a76bde21c14'),
	('65edf444-ab3d-4cbd-93dd-7e96b4741ef5', '2026-07-07 15:07:06.789995+00', '2026-07-07 15:07:06.789995+00', 'password', '47531194-6bad-4052-a504-f2c4d1e93210'),
	('502ac702-f510-4113-bd16-b7a6ccccb132', '2026-07-07 15:07:12.872233+00', '2026-07-07 15:07:12.872233+00', 'password', '376ecfbe-790e-4325-8075-e1a180752812'),
	('5acb5fca-c31d-4177-b6f0-9281a971fa06', '2026-07-07 15:07:17.314483+00', '2026-07-07 15:07:17.314483+00', 'password', '2ede41a2-49d8-424f-8b97-e496cd8ae6fe'),
	('e29fba73-c1f4-4c96-860a-e7cea0106b2c', '2026-07-08 03:07:35.168466+00', '2026-07-08 03:07:35.168466+00', 'password', '1f16724c-9f03-40aa-a809-907cf78d2cc6'),
	('4e67fbfe-bb01-4231-a63f-57bf70c12466', '2026-07-08 03:08:55.559812+00', '2026-07-08 03:08:55.559812+00', 'password', '7adf9a09-1d98-41da-9ddb-88c26217b148'),
	('ba27552d-780b-4746-b141-11940c59e53d', '2026-07-08 03:09:54.431796+00', '2026-07-08 03:09:54.431796+00', 'password', '5b0f3d11-8824-40fa-b947-d83c56f407ff'),
	('2fcfe560-bc04-4317-9921-b1ab8d7b7b1f', '2026-07-08 03:52:13.749344+00', '2026-07-08 03:52:13.749344+00', 'password', 'b635f843-0604-427e-9169-d9748e4b2332'),
	('6580a247-5e38-4d6c-95f3-ec31df690bb8', '2026-07-08 03:52:26.328193+00', '2026-07-08 03:52:26.328193+00', 'password', '5b3bc0d7-2b54-44dc-b773-d4977ecdb712'),
	('6be14b93-f744-41cc-aef5-622e310706a5', '2026-07-10 09:28:45.040365+00', '2026-07-10 09:28:45.040365+00', 'password', '52978742-54d4-422d-94c5-7187d7648ae3'),
	('a42d95ee-81d3-401f-af4f-066a31581b52', '2026-07-10 10:11:05.250757+00', '2026-07-10 10:11:05.250757+00', 'password', '2f6b0620-2fbf-443c-b321-4979bc5d0745'),
	('8716354e-6ace-4fee-9f86-74422a8542be', '2026-07-10 10:11:15.161841+00', '2026-07-10 10:11:15.161841+00', 'password', '7b39a6ae-bf46-4cc6-9215-86eb1ae59dbf'),
	('7e6074a8-833c-4660-9e5f-150ea71d8757', '2026-07-10 11:36:24.65219+00', '2026-07-10 11:36:24.65219+00', 'password', '548351a9-ecfa-4815-946e-ad17a33c4eb4'),
	('7d274838-1fd1-4f81-85b5-7a39ba4199e1', '2026-07-10 11:36:38.299229+00', '2026-07-10 11:36:38.299229+00', 'password', '868fa52a-7945-4bd0-941b-92ee378da59d'),
	('a9731a5f-756f-47ea-818e-a1a064c59110', '2026-07-10 11:52:18.486613+00', '2026-07-10 11:52:18.486613+00', 'password', '3189a436-35bb-46c4-b25b-0dcf4108fe88'),
	('0c0c3dfb-2e8d-4abd-b1bd-013b88d8c038', '2026-07-10 12:12:34.221655+00', '2026-07-10 12:12:34.221655+00', 'password', 'a4ce0b04-2c97-49d2-ac85-62acdff7eaae'),
	('4e1d4484-60d6-40ea-8936-d0529b120f32', '2026-07-10 13:32:04.790287+00', '2026-07-10 13:32:04.790287+00', 'password', 'a48eb153-780b-4fdb-bcf0-244db8955b75'),
	('5cbb0087-0316-403d-8ad9-1fb722dd9ab9', '2026-07-12 10:09:43.318757+00', '2026-07-12 10:09:43.318757+00', 'password', 'b3916fd3-6fdc-43fb-bc74-8a3b34dbb573'),
	('deda75d7-6e66-40b6-a565-53f44b5cb722', '2026-07-12 10:09:49.114824+00', '2026-07-12 10:09:49.114824+00', 'password', 'f014beb8-5008-4e22-ab40-dc322f5c41ac'),
	('62a79602-70d7-4108-9813-7f2a1d7b94d4', '2026-07-12 10:22:11.976426+00', '2026-07-12 10:22:11.976426+00', 'password', 'f2a22208-28a0-4dca-be24-868f67aea7df'),
	('4e71b538-829e-4400-b72f-0934d629a913', '2026-07-12 10:23:50.837945+00', '2026-07-12 10:23:50.837945+00', 'password', 'ffb0cb31-1efc-4205-9fc1-ec8c187073e6'),
	('83b7e0bb-28bd-4e87-a6c6-2bff3c0bcd16', '2026-07-12 11:50:29.404089+00', '2026-07-12 11:50:29.404089+00', 'password', 'fc2ab434-37e3-4cb6-a986-5bcb325615f7'),
	('bec40fd5-eae0-4af3-a370-c09e1a691be4', '2026-07-12 11:58:30.50925+00', '2026-07-12 11:58:30.50925+00', 'password', 'aac0f982-c702-4fb3-b969-223d7f7b37b1'),
	('4e538703-0894-4020-8c71-0134b255fb56', '2026-07-12 11:58:34.018707+00', '2026-07-12 11:58:34.018707+00', 'password', '8b6e837e-7a99-4d21-b8dd-87abf22d6cc3');


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") VALUES
	('00000000-0000-0000-0000-000000000000', 2, '2bxnwmgsko3w', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-05 14:12:53.360752+00', '2026-07-05 14:12:53.360752+00', NULL, 'd9a9fd5e-82df-4ed3-aa99-df4b168cacd3'),
	('00000000-0000-0000-0000-000000000000', 3, 'if33exvjq73r', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-05 14:23:05.521538+00', '2026-07-05 14:23:05.521538+00', NULL, '1e3bfcdb-74a7-45eb-b4c4-a749128d0dc5'),
	('00000000-0000-0000-0000-000000000000', 4, 'qhmpq7hk3adv', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-05 14:28:05.125785+00', '2026-07-05 14:28:05.125785+00', NULL, '663dfde6-2d75-47d3-abeb-ca6b4358e292'),
	('00000000-0000-0000-0000-000000000000', 5, 'oco7oxffx7ud', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-05 14:28:06.956122+00', '2026-07-05 14:28:06.956122+00', NULL, 'f381f904-36d9-444f-a063-c0d8ca12248a'),
	('00000000-0000-0000-0000-000000000000', 6, 'asytccm3pcdy', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-05 14:28:08.498402+00', '2026-07-05 14:28:08.498402+00', NULL, '22de82a0-ff4f-4187-9f4e-793a2889b4b6'),
	('00000000-0000-0000-0000-000000000000', 7, 'fygoxf2o4ady', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-05 14:28:11.533729+00', '2026-07-05 14:28:11.533729+00', NULL, 'c8f5cd1e-9e96-4131-872d-5dc133d4ed23'),
	('00000000-0000-0000-0000-000000000000', 8, 'mzsydptskx7d', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-05 14:28:12.378916+00', '2026-07-05 14:28:12.378916+00', NULL, '21730945-8cfc-482c-94fd-50adee9256d4'),
	('00000000-0000-0000-0000-000000000000', 9, '24glmkngl7vq', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-05 14:28:13.608811+00', '2026-07-05 14:28:13.608811+00', NULL, '1bbce163-f226-46f5-8f6f-54bcf4eb0edd'),
	('00000000-0000-0000-0000-000000000000', 10, 'mwyrf3f2fokn', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-05 14:28:15.499001+00', '2026-07-05 14:28:15.499001+00', NULL, '936864e2-418a-4852-a675-4c78fd51ee60'),
	('00000000-0000-0000-0000-000000000000', 11, 'hfsgf54jotw2', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-05 14:28:17.203186+00', '2026-07-05 14:28:17.203186+00', NULL, '0c38c224-23cb-4753-bc55-4da6e2b50960'),
	('00000000-0000-0000-0000-000000000000', 12, 'aab6ujfsr2di', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-05 14:28:20.842321+00', '2026-07-05 14:28:20.842321+00', NULL, '8a95c576-5f30-4fe3-a21f-a40436d11ae3'),
	('00000000-0000-0000-0000-000000000000', 13, 'hgikbazizqs4', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', true, '2026-07-05 14:28:21.394844+00', '2026-07-06 00:48:57.563905+00', NULL, '75867655-0497-4882-8fe3-b516737b9e7b'),
	('00000000-0000-0000-0000-000000000000', 14, '647s76jxb2o3', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-06 00:48:57.575684+00', '2026-07-06 00:48:57.575684+00', 'hgikbazizqs4', '75867655-0497-4882-8fe3-b516737b9e7b'),
	('00000000-0000-0000-0000-000000000000', 15, 'ajqxx3fsbozh', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-06 00:49:05.38099+00', '2026-07-06 00:49:05.38099+00', NULL, '034b4348-0386-4834-983a-f904f528a813'),
	('00000000-0000-0000-0000-000000000000', 16, 'bzniz7ogm6of', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-06 00:49:59.294909+00', '2026-07-06 00:49:59.294909+00', NULL, '75dd9862-4307-42e6-aa81-31e72fc3c768'),
	('00000000-0000-0000-0000-000000000000', 17, 'lxxmkub22mvw', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-06 00:50:20.69827+00', '2026-07-06 00:50:20.69827+00', NULL, '930a3174-e9ad-4372-8d39-64df585c8022'),
	('00000000-0000-0000-0000-000000000000', 18, 'dfbozp7p4pmk', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-06 00:54:05.639679+00', '2026-07-06 00:54:05.639679+00', NULL, '17c61f3d-f3e9-44bf-a4ca-817a783da4f4'),
	('00000000-0000-0000-0000-000000000000', 19, 'r6m3d6d656t7', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-06 01:03:51.086238+00', '2026-07-06 01:03:51.086238+00', NULL, '5fb9187b-b900-4051-9fa2-287ad3ede4ee'),
	('00000000-0000-0000-0000-000000000000', 20, '3jxjezltzuoh', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-06 01:03:57.015213+00', '2026-07-06 01:03:57.015213+00', NULL, '5e696e77-1934-4bed-8a6a-ce64c17f1bac'),
	('00000000-0000-0000-0000-000000000000', 21, 'zwlob5vgwmmu', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-06 01:03:57.931132+00', '2026-07-06 01:03:57.931132+00', NULL, '1ec18391-96c0-41d3-9823-3a5c87b7d75e'),
	('00000000-0000-0000-0000-000000000000', 22, 'ydzrzempjyeu', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-06 01:23:32.397602+00', '2026-07-06 01:23:32.397602+00', NULL, '35994998-cbe5-44ce-8b96-66bfc8b1fc6e'),
	('00000000-0000-0000-0000-000000000000', 23, '7cndboq6fuel', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-06 01:24:12.43918+00', '2026-07-06 01:24:12.43918+00', NULL, '9118abc3-e5b5-4c41-9366-eacc77e51af6'),
	('00000000-0000-0000-0000-000000000000', 24, 'u22asy3aomla', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-06 01:24:26.379305+00', '2026-07-06 01:24:26.379305+00', NULL, '46961c59-d72c-4063-a9a6-e6810153383b'),
	('00000000-0000-0000-0000-000000000000', 25, 'aqswvo573qcm', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-06 01:24:28.919337+00', '2026-07-06 01:24:28.919337+00', NULL, '45a60508-17a3-4cfb-9738-62eaa5517caa'),
	('00000000-0000-0000-0000-000000000000', 26, 'rst5err254rv', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-06 01:24:31.444994+00', '2026-07-06 01:24:31.444994+00', NULL, '462f6e9a-ce17-4811-b500-eece7f80820f'),
	('00000000-0000-0000-0000-000000000000', 27, 'yddl75f44dcf', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-06 01:34:36.702916+00', '2026-07-06 01:34:36.702916+00', NULL, 'ba89a12c-40ff-4c41-a043-eb5ff5c384c3'),
	('00000000-0000-0000-0000-000000000000', 28, 'ejmwshlf7cxd', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-06 01:41:27.84795+00', '2026-07-06 01:41:27.84795+00', NULL, 'ed85383c-8163-4d46-9c07-85d16e54dba2'),
	('00000000-0000-0000-0000-000000000000', 29, 'hxczoxaqbetk', '62fcac55-c64e-487d-8564-fc35c45f7907', false, '2026-07-06 02:33:07.384928+00', '2026-07-06 02:33:07.384928+00', NULL, 'df5b16d4-32b9-4e1a-8014-8f3a3c5f05bf'),
	('00000000-0000-0000-0000-000000000000', 30, '7dlmszvhamfz', '62fcac55-c64e-487d-8564-fc35c45f7907', false, '2026-07-06 02:33:25.204934+00', '2026-07-06 02:33:25.204934+00', NULL, '0c8622b6-2fff-4f4f-b7b0-aa572fce03c9'),
	('00000000-0000-0000-0000-000000000000', 31, 'gzfh4iw4v5kz', '62fcac55-c64e-487d-8564-fc35c45f7907', false, '2026-07-06 02:33:26.745271+00', '2026-07-06 02:33:26.745271+00', NULL, '207b25c1-30e2-4c81-96cd-264abc76bbbc'),
	('00000000-0000-0000-0000-000000000000', 32, '6tsup3lggkwn', '62fcac55-c64e-487d-8564-fc35c45f7907', false, '2026-07-06 02:33:28.774228+00', '2026-07-06 02:33:28.774228+00', NULL, '8716e2ad-a6b0-40d9-a21e-583e432e1b0e'),
	('00000000-0000-0000-0000-000000000000', 33, 'icr5ex2owhtl', '62fcac55-c64e-487d-8564-fc35c45f7907', false, '2026-07-06 02:33:29.983528+00', '2026-07-06 02:33:29.983528+00', NULL, '45da9f9c-9061-4ccc-957a-f2a373e689e2'),
	('00000000-0000-0000-0000-000000000000', 34, 'daz2nnwbwxln', '62fcac55-c64e-487d-8564-fc35c45f7907', false, '2026-07-06 02:33:31.131219+00', '2026-07-06 02:33:31.131219+00', NULL, '9eb11a89-349b-4c4e-aa63-b78342bfe88d'),
	('00000000-0000-0000-0000-000000000000', 35, '5coepwprfdyj', '62fcac55-c64e-487d-8564-fc35c45f7907', false, '2026-07-06 03:01:39.97015+00', '2026-07-06 03:01:39.97015+00', NULL, '40dab799-2ea4-4fb3-b22e-85a1131ad2f4'),
	('00000000-0000-0000-0000-000000000000', 36, 'rid3elrplchr', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-06 03:04:47.778281+00', '2026-07-06 03:04:47.778281+00', NULL, '9da87a08-35de-452e-9ec2-c2acb49da89c'),
	('00000000-0000-0000-0000-000000000000', 37, 'ps3ohof5lc6v', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-06 03:05:42.463258+00', '2026-07-06 03:05:42.463258+00', NULL, '321b1693-d907-48bd-935b-aadc403ea2b4'),
	('00000000-0000-0000-0000-000000000000', 38, 'tnuz7jvtxrjy', '62fcac55-c64e-487d-8564-fc35c45f7907', false, '2026-07-06 03:05:50.778862+00', '2026-07-06 03:05:50.778862+00', NULL, 'cb24c1fe-91b4-4b56-ae43-f599866827e4'),
	('00000000-0000-0000-0000-000000000000', 39, 'toiqgwaduat3', '62fcac55-c64e-487d-8564-fc35c45f7907', false, '2026-07-06 03:08:37.810472+00', '2026-07-06 03:08:37.810472+00', NULL, '3ab2e4f4-dbb1-4506-bca6-4ca26b99c213'),
	('00000000-0000-0000-0000-000000000000', 40, 'kbnwsb6nyuxu', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', true, '2026-07-06 03:09:08.858769+00', '2026-07-06 04:07:10.276218+00', NULL, 'f9283fe1-9b28-42b5-8a49-e3d93761506b'),
	('00000000-0000-0000-0000-000000000000', 41, 'wofiedb2ycav', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', true, '2026-07-06 04:07:10.280081+00', '2026-07-06 05:05:36.666165+00', 'kbnwsb6nyuxu', 'f9283fe1-9b28-42b5-8a49-e3d93761506b'),
	('00000000-0000-0000-0000-000000000000', 42, 's6vcozbpa2pf', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', true, '2026-07-06 05:05:36.679981+00', '2026-07-07 03:23:55.178131+00', 'wofiedb2ycav', 'f9283fe1-9b28-42b5-8a49-e3d93761506b'),
	('00000000-0000-0000-0000-000000000000', 43, 'ywkyb5kxxilq', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', true, '2026-07-07 03:23:55.186383+00', '2026-07-07 05:21:05.177952+00', 's6vcozbpa2pf', 'f9283fe1-9b28-42b5-8a49-e3d93761506b'),
	('00000000-0000-0000-0000-000000000000', 44, 'r2mjm3zhzpga', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', true, '2026-07-07 05:21:05.198652+00', '2026-07-07 07:50:21.143678+00', 'ywkyb5kxxilq', 'f9283fe1-9b28-42b5-8a49-e3d93761506b'),
	('00000000-0000-0000-0000-000000000000', 45, 'i6zc2t52t6z3', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-07 07:50:21.158419+00', '2026-07-07 07:50:21.158419+00', 'r2mjm3zhzpga', 'f9283fe1-9b28-42b5-8a49-e3d93761506b'),
	('00000000-0000-0000-0000-000000000000', 46, '3pevjre5pyt2', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', true, '2026-07-07 07:55:24.016328+00', '2026-07-07 14:55:54.671377+00', NULL, '50915a79-afed-4138-951a-f25159d0bd6f'),
	('00000000-0000-0000-0000-000000000000', 47, 'opq4elqiq3so', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-07 14:55:54.678537+00', '2026-07-07 14:55:54.678537+00', '3pevjre5pyt2', '50915a79-afed-4138-951a-f25159d0bd6f'),
	('00000000-0000-0000-0000-000000000000', 48, 'cyoz766rcqrn', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-07 14:56:07.058088+00', '2026-07-07 14:56:07.058088+00', NULL, '67b9f745-5f4a-4405-8f76-bb1ecb828b81'),
	('00000000-0000-0000-0000-000000000000', 49, 'feanq3hbop3n', '27336dc6-ac2e-437e-b9fc-2b5fed623f1f', false, '2026-07-07 14:57:06.82947+00', '2026-07-07 14:57:06.82947+00', NULL, '78bc01e1-72b2-459b-82e7-7049f8477438'),
	('00000000-0000-0000-0000-000000000000', 50, 'mpmvqzywxqt5', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-07 14:58:24.486798+00', '2026-07-07 14:58:24.486798+00', NULL, 'df054930-6600-41ed-a5fc-6fb00fda3bad'),
	('00000000-0000-0000-0000-000000000000', 51, '7sl3fprk22kk', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-07 14:58:36.725391+00', '2026-07-07 14:58:36.725391+00', NULL, 'e0479285-2cd8-47b1-97e3-c195f865a457'),
	('00000000-0000-0000-0000-000000000000', 52, '5sj5uyljstq4', '27336dc6-ac2e-437e-b9fc-2b5fed623f1f', false, '2026-07-07 14:58:41.447513+00', '2026-07-07 14:58:41.447513+00', NULL, 'a002b880-2a62-4104-9139-9820fac5d628'),
	('00000000-0000-0000-0000-000000000000', 53, '366jizfrmlyi', '27336dc6-ac2e-437e-b9fc-2b5fed623f1f', false, '2026-07-07 14:58:42.844889+00', '2026-07-07 14:58:42.844889+00', NULL, '9efeb4bb-8f5a-46c1-9a9a-1569092d0f90'),
	('00000000-0000-0000-0000-000000000000', 54, 'b6gvojws5nyc', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-07 14:58:45.591019+00', '2026-07-07 14:58:45.591019+00', NULL, 'd8cf0217-c6d7-41c0-8a94-e6e99ad7d7ff'),
	('00000000-0000-0000-0000-000000000000', 55, 'z7vrpgu7p23m', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-07 14:59:02.24986+00', '2026-07-07 14:59:02.24986+00', NULL, 'a7c79baa-7b95-4af3-a0b3-a50a0fd0d6a0'),
	('00000000-0000-0000-0000-000000000000', 56, 'qyv5fht7auvl', '27336dc6-ac2e-437e-b9fc-2b5fed623f1f', false, '2026-07-07 15:07:06.786494+00', '2026-07-07 15:07:06.786494+00', NULL, '65edf444-ab3d-4cbd-93dd-7e96b4741ef5'),
	('00000000-0000-0000-0000-000000000000', 57, 'yvaut3zq2psf', '27336dc6-ac2e-437e-b9fc-2b5fed623f1f', false, '2026-07-07 15:07:12.870751+00', '2026-07-07 15:07:12.870751+00', NULL, '502ac702-f510-4113-bd16-b7a6ccccb132'),
	('00000000-0000-0000-0000-000000000000', 58, 'rk3ectdtvqzy', '27336dc6-ac2e-437e-b9fc-2b5fed623f1f', true, '2026-07-07 15:07:17.313209+00', '2026-07-07 16:09:52.666579+00', NULL, '5acb5fca-c31d-4177-b6f0-9281a971fa06'),
	('00000000-0000-0000-0000-000000000000', 59, 'unlew76a2kkb', '27336dc6-ac2e-437e-b9fc-2b5fed623f1f', true, '2026-07-07 16:09:52.677322+00', '2026-07-08 00:48:38.169402+00', 'rk3ectdtvqzy', '5acb5fca-c31d-4177-b6f0-9281a971fa06'),
	('00000000-0000-0000-0000-000000000000', 60, 'qk6gat32apvt', '27336dc6-ac2e-437e-b9fc-2b5fed623f1f', true, '2026-07-08 00:48:38.177431+00', '2026-07-08 01:55:32.67157+00', 'unlew76a2kkb', '5acb5fca-c31d-4177-b6f0-9281a971fa06'),
	('00000000-0000-0000-0000-000000000000', 61, 'aczbiwqkb7hv', '27336dc6-ac2e-437e-b9fc-2b5fed623f1f', true, '2026-07-08 01:55:32.683332+00', '2026-07-08 02:53:59.366331+00', 'qk6gat32apvt', '5acb5fca-c31d-4177-b6f0-9281a971fa06'),
	('00000000-0000-0000-0000-000000000000', 63, 'ppb5gsrph35g', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-08 03:07:35.163729+00', '2026-07-08 03:07:35.163729+00', NULL, 'e29fba73-c1f4-4c96-860a-e7cea0106b2c'),
	('00000000-0000-0000-0000-000000000000', 64, 'f4qgjcvmrwqc', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-08 03:08:55.557368+00', '2026-07-08 03:08:55.557368+00', NULL, '4e67fbfe-bb01-4231-a63f-57bf70c12466'),
	('00000000-0000-0000-0000-000000000000', 65, 'huztkolnzugt', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-08 03:09:54.430325+00', '2026-07-08 03:09:54.430325+00', NULL, 'ba27552d-780b-4746-b141-11940c59e53d'),
	('00000000-0000-0000-0000-000000000000', 62, 'poanufp5le4g', '27336dc6-ac2e-437e-b9fc-2b5fed623f1f', true, '2026-07-08 02:53:59.379673+00', '2026-07-08 03:52:04.18118+00', 'aczbiwqkb7hv', '5acb5fca-c31d-4177-b6f0-9281a971fa06'),
	('00000000-0000-0000-0000-000000000000', 66, 'vcegbjxfjb7l', '27336dc6-ac2e-437e-b9fc-2b5fed623f1f', false, '2026-07-08 03:52:04.185751+00', '2026-07-08 03:52:04.185751+00', 'poanufp5le4g', '5acb5fca-c31d-4177-b6f0-9281a971fa06'),
	('00000000-0000-0000-0000-000000000000', 67, 'fxmu4miwhvh2', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-08 03:52:13.747506+00', '2026-07-08 03:52:13.747506+00', NULL, '2fcfe560-bc04-4317-9921-b1ab8d7b7b1f'),
	('00000000-0000-0000-0000-000000000000', 68, 'wkbjqk6w6lhg', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-08 03:52:26.326751+00', '2026-07-08 03:52:26.326751+00', NULL, '6580a247-5e38-4d6c-95f3-ec31df690bb8'),
	('00000000-0000-0000-0000-000000000000', 69, 'rjdggkgvwffw', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-10 09:28:45.007299+00', '2026-07-10 09:28:45.007299+00', NULL, '6be14b93-f744-41cc-aef5-622e310706a5'),
	('00000000-0000-0000-0000-000000000000', 70, 'xwl27ng52oah', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-10 10:11:05.244646+00', '2026-07-10 10:11:05.244646+00', NULL, 'a42d95ee-81d3-401f-af4f-066a31581b52'),
	('00000000-0000-0000-0000-000000000000', 71, 'nv3vuyopecju', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-10 10:11:15.159984+00', '2026-07-10 10:11:15.159984+00', NULL, '8716354e-6ace-4fee-9f86-74422a8542be'),
	('00000000-0000-0000-0000-000000000000', 72, 'bkbygi7wbxa3', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-10 11:36:24.620396+00', '2026-07-10 11:36:24.620396+00', NULL, '7e6074a8-833c-4660-9e5f-150ea71d8757'),
	('00000000-0000-0000-0000-000000000000', 73, 's4wy5bvyclnr', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-10 11:36:38.297776+00', '2026-07-10 11:36:38.297776+00', NULL, '7d274838-1fd1-4f81-85b5-7a39ba4199e1'),
	('00000000-0000-0000-0000-000000000000', 74, 'i66dybfumphn', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-10 11:52:18.482041+00', '2026-07-10 11:52:18.482041+00', NULL, 'a9731a5f-756f-47ea-818e-a1a064c59110'),
	('00000000-0000-0000-0000-000000000000', 75, '4rvlz3poi2te', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-10 12:12:34.218407+00', '2026-07-10 12:12:34.218407+00', NULL, '0c0c3dfb-2e8d-4abd-b1bd-013b88d8c038'),
	('00000000-0000-0000-0000-000000000000', 76, 'u6nd3ma2f3j7', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-10 13:32:04.768466+00', '2026-07-10 13:32:04.768466+00', NULL, '4e1d4484-60d6-40ea-8936-d0529b120f32'),
	('00000000-0000-0000-0000-000000000000', 77, '7durw6jbq543', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-12 10:09:43.292335+00', '2026-07-12 10:09:43.292335+00', NULL, '5cbb0087-0316-403d-8ad9-1fb722dd9ab9'),
	('00000000-0000-0000-0000-000000000000', 78, 'hmdrcoxtvwap', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-12 10:09:49.113516+00', '2026-07-12 10:09:49.113516+00', NULL, 'deda75d7-6e66-40b6-a565-53f44b5cb722'),
	('00000000-0000-0000-0000-000000000000', 79, '47ig6x4oscpe', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-12 10:22:11.972603+00', '2026-07-12 10:22:11.972603+00', NULL, '62a79602-70d7-4108-9813-7f2a1d7b94d4'),
	('00000000-0000-0000-0000-000000000000', 80, 'ip2ggp4abd6i', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-12 10:23:50.834694+00', '2026-07-12 10:23:50.834694+00', NULL, '4e71b538-829e-4400-b72f-0934d629a913'),
	('00000000-0000-0000-0000-000000000000', 81, '3xs2oc7fvwt5', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-12 11:50:29.39821+00', '2026-07-12 11:50:29.39821+00', NULL, '83b7e0bb-28bd-4e87-a6c6-2bff3c0bcd16'),
	('00000000-0000-0000-0000-000000000000', 82, 'oipihge7pxgq', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-12 11:58:30.504754+00', '2026-07-12 11:58:30.504754+00', NULL, 'bec40fd5-eae0-4af3-a370-c09e1a691be4'),
	('00000000-0000-0000-0000-000000000000', 83, 's4wa72i5n6ko', '78c5ea2b-c4f3-4bec-9c6a-385d7725d1d7', false, '2026-07-12 11:58:34.017196+00', '2026-07-12 11:58:34.017196+00', NULL, '4e538703-0894-4020-8c71-0134b255fb56');


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: ACCOUNTS; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: STORES; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."STORES" ("id", "time_in", "username", "ipv4", "branch", "session_id", "session_expiration", "time_out") VALUES
	(3, '2026-07-10 11:36:38.299+00', 'genuinepower123@gmail.com', '136.158.11.170,136.158.11.170, 99.82.173.51', 'branch1', '2ae2e85d-7dc0-4dc2-a33a-e722113d9eb4', '2026-07-10 16:00:00+00', NULL);


--
-- Data for Name: INVENTORY_RECONCILIATION; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: NO_WORKING_DAYS; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: PRICE; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: SALES; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: STORE_DEFAULT; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."STORE_DEFAULT" ("id", "created_at", "branch", "small_cups", "medium_cups", "large_cups", "opening_cash", "opening_potatoes") VALUES
	(1, '2026-07-07 14:23:08.536939+00', 'branch1', 25, 25, 25, 500, 50);


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 83, true);


--
-- Name: ACCOUNTS_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."ACCOUNTS_id_seq"', 1, false);


--
-- Name: INVENTORY_RECONCILIATION_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."INVENTORY_RECONCILIATION_id_seq"', 1, false);


--
-- Name: NO_WORKING_DAYS_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."NO_WORKING_DAYS_id_seq"', 1, false);


--
-- Name: PRICING_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."PRICING_id_seq"', 1, false);


--
-- Name: SALES_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."SALES_id_seq"', 1, false);


--
-- Name: STORES_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."STORES_id_seq"', 10, true);


--
-- Name: STORE_DEFAULT_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."STORE_DEFAULT_id_seq"', 1, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict aKhTkVqAU3q4o4JbaMpPpm9CcQsWmfdCgQJ4Jyz4V4uN4z0GexmYSXKgO3DsePk

RESET ALL;

SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict DhV4zZ46ybKXV04DjvoyMIUvNnjIyrm3lQ0XXFUAIBOS6acijvArx62WrIdS10p

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
-- Data for Name: charts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."charts" ("id", "title", "difficulty", "level", "chart_constant", "note_count", "bpm", "length", "version", "chart_designer", "jacket_designer", "song_id", "jacket_override", "artist") FROM stdin;
2	Sayonara Hatsukoi	PRS	4	4.5	305	178	1:55	1.0	Nitro	\N	sayonarahatsukoi	f	REDSHiFT
90	Flyburg and Endroll	PST	3	3	413	180	2:25	1.0	N	アリスシャッハと魔法の楽団	flyburg	f	アリスシャッハと魔法の楽団
91	Flyburg and Endroll	PRS	6	6	650	180	2:25	1.0	N	アリスシャッハと魔法の楽団	flyburg	f	アリスシャッハと魔法の楽団
92	Flyburg and Endroll	FTR	9	9	930	180	2:25	1.0	NーHelix	アリスシャッハと魔法の楽団	flyburg	f	アリスシャッハと魔法の楽団
93	Nirv lucE	PST	2	2.5	297	260	2:08	1.0	東星※紅空	シエラ	nirvluce	f	しーけー
94	Nirv lucE	PRS	7	7	547	260	2:08	1.0	東星※紅空	シエラ	nirvluce	f	しーけー
95	Nirv lucE	FTR	10	10.2	980	260	2:08	1.0	東星※紅空	シエラ	nirvluce	f	しーけー
96	Paradise	PST	1	1	253	126	2:28	1.0	Nitro	ましろみ のあ	paradise	f	Sound Souler
97	Paradise	PRS	4	4	349	126	2:28	1.0	Nitro	ましろみ のあ	paradise	f	Sound Souler
98	Paradise	FTR	7+	7.8	729	126	2:28	1.0	Nitro	ましろみ のあ	paradise	f	Sound Souler
99	Brand new world	PST	2	2	322	160	2:24	1.0	Nitro 2.0	\N	brandnewworld	f	U-ske
100	Brand new world	PRS	4	4	432	160	2:24	1.0	Nitro 2.0	\N	brandnewworld	f	U-ske
101	Brand new world	FTR	7+	7.8	787	160	2:24	1.0	Nitro 2.0	\N	brandnewworld	f	U-ske
102	DataErr0r	PST	3	3	502	180	2:05	1.1	ToastErr0r	Photonskyto	dataerror	f	Cosmograph
103	DataErr0r	PRS	7	7	785	180	2:05	1.1	ToastErr0r	Photonskyto	dataerror	f	Cosmograph
104	DataErr0r	FTR	9	9.5	955	180	2:05	1.1	ToastErr0r	Photonskyto	dataerror	f	Cosmograph
105	CROSS†SOUL	PST	4	4	606	200	2:19	1.1	k//eternal	Khronetic	crosssoul	f	HyuN feat. Syepias
106	CROSS†SOUL	PRS	7	7	823	200	2:19	1.1	k//eternal	Khronetic	crosssoul	f	HyuN feat. Syepias
107	CROSS†SOUL	FTR	9	9.4	1081	200	2:19	1.1	k//eternal	Khronetic	crosssoul	f	HyuN feat. Syepias
108	Your voice so... feat. Such	PST	3	3.5	469	176	2:30	1.1	Nitro	DJ Poyoshi	yourvoiceso	f	PSYQUI
109	Your voice so... feat. Such	PRS	6	6.5	677	176	2:30	1.1	Nitro	DJ Poyoshi	yourvoiceso	f	PSYQUI
110	Your voice so... feat. Such	FTR	9	9.4	1013	176	2:30	1.1	Nitro	DJ Poyoshi	yourvoiceso	f	PSYQUI
111	Chronostasis	PST	3	3.5	619	196	2:13	1.1	Kurorak	\N	chronostasis	f	黒皇帝
112	Chronostasis	PRS	7	7.5	812	196	2:13	1.1	Kurorak	\N	chronostasis	f	黒皇帝
113	Chronostasis	FTR	8+	8.9	916	196	2:13	1.1	Kurorak	\N	chronostasis	f	黒皇帝
114	Kanagawa Cyber Culvert	PST	1	1	375	180	2:29	1.1	Nitro	白鳥怜	kanagawa	f	南ゆに
115	Kanagawa Cyber Culvert	PRS	5	5.5	707	180	2:29	1.1	Nitro	白鳥怜	kanagawa	f	南ゆに
116	Kanagawa Cyber Culvert	FTR	9	9	1111	180	2:29	1.1	Nitro	白鳥怜	kanagawa	f	南ゆに
117	Kanagawa Cyber Culvert	BYD	9+	9.8	1121	180	2:29	3.10	Exschwas↓on	白鳥怜 + Khronetic	kanagawa	t	南ゆに
118	Moonlight of Sand Castle	PST	1	1.5	418	160	2:26	1.1	Kurorak	\N	moonlightofsandcastle	f	旅人E
119	Moonlight of Sand Castle	PRS	5	5	394	160	2:26	1.1	Kurorak	\N	moonlightofsandcastle	f	旅人E
120	Moonlight of Sand Castle	FTR	7+	7.8	645	160	2:26	1.1	Kurorak	\N	moonlightofsandcastle	f	旅人E
121	REconstruction	PST	2	2.5	347	180	1:57	1.1	Nitro	\N	reconstruction	f	Ryazan
122	REconstruction	PRS	6	6	469	180	1:57	1.1	Nitro	\N	reconstruction	f	Ryazan
123	REconstruction	FTR	8	8.4	825	180	1:57	1.1	Nitro	\N	reconstruction	f	Ryazan
124	Evoltex (poppi'n mix)	PST	2	2	297	205	1:46	1.1	k//eternal	\N	evoltex	f	Arch vs n3pu
125	Evoltex (poppi'n mix)	PRS	7	7	627	205	1:46	1.1	k//eternal	\N	evoltex	f	Arch vs n3pu
126	Evoltex (poppi'n mix)	FTR	8+	8.9	775	205	1:46	1.1	k//eternal	\N	evoltex	f	Arch vs n3pu
127	Oracle	PST	3	3	425	152	2:22	1.1	Nitro	\N	oracle	f	TQ☆
128	Oracle	PRS	5	5.5	508	152	2:22	1.1	Nitro	\N	oracle	f	TQ☆
129	Oracle	FTR	9	9.3	963	152	2:22	1.1	Nitro	\N	oracle	f	TQ☆
130	αterlβus	PST	4	4	505	202	2:00	1.1	τoastεr	\N	aterlbus	f	Aoi
131	αterlβus	PRS	7	7.5	668	202	2:00	1.1	τoastεr	\N	aterlbus	f	Aoi
132	αterlβus	FTR	10	10.2	1030	202	2:00	1.1	τoastεr	\N	aterlbus	f	Aoi
133	Clotho and the stargazer	PST	2	2	519	230	2:19	1.1	小東星	yoshimo	clotho	f	しーけー
134	Clotho and the stargazer	PRS	5	5	745	230	2:19	1.1	小東星	yoshimo	clotho	f	しーけー
135	Clotho and the stargazer	FTR	7+	7.8	1021	230	2:19	1.1	小東星	yoshimo	clotho	f	しーけー
136	Clotho and the stargazer	ETR	8+	8.8	1031	230	2:19	5.4	eién	yoshimo	clotho	f	しーけー
137	Impure Bird	PST	2	2	350	184	1:56	1.1	Kurorak	Nano Kun	impurebird	f	MIssionary
138	Impure Bird	PRS	5	5.5	518	184	1:56	1.1	Kurorak	Nano Kun	impurebird	f	MIssionary
139	Impure Bird	FTR	9	9.4	805	184	1:56	1.1	Kurorak	Nano Kun	impurebird	f	MIssionary
140	Ignotus	PST	3	3.5	579	170	2:26	1.1	Toaster	Khronetic	ignotus	f	ak+q
141	Ignotus	PRS	6	6.5	809	170	2:26	1.1	Toaster	Khronetic	ignotus	f	ak+q
142	Ignotus	FTR	9	9.3	1225	170	2:26	1.1	Toaster	Khronetic	ignotus	f	ak+q
143	Ignotus	BYD	9+	9.9	1077	170	2:26	3.12	Toaster × 石樂	Khronetic	ignotus	t	Arcaea Sound Team
6	Lost Civilization	PRS	7	7	690	75 - 210	2:04	1.0	Toaster	\N	lostcivilization	f	Laur vs CK
7	Lost Civilization	FTR	9	9.2	986	75 - 210	2:04	1.0	Toaster	\N	lostcivilization	f	Laur vs CK
8	Lost Civilization	BYD	9+	9.8	1061	75 - 210	2:04	3.6	Nitro affected by Nitro	みしゃも + yoshimo	lostcivilization	t	Laur vs CK
144	Lethaeus	PST	3	3.5	480	155	2:23	1.1	夜浪	softmode	lethaeus	f	Silentroom
145	Lethaeus	PRS	6	6.5	717	155	2:23	1.1	夜浪	softmode	lethaeus	f	Silentroom
146	Lethaeus	FTR	9+	9.7	900	155	2:23	1.1	夜浪	softmode	lethaeus	f	Silentroom
147	Romance Wars	PST	1	1	423	187	2:06	1.1	Kurorak	橙乃遥	romancewars	f	U-ske (feat. lueur)
148	Romance Wars	PRS	4	4	378	187	2:06	1.1	Kurorak	橙乃遥	romancewars	f	U-ske (feat. lueur)
149	Romance Wars	FTR	7+	7.8	641	187	2:06	1.1	Kurorak	橙乃遥	romancewars	f	U-ske (feat. lueur)
150	Blossoms	PST	1	1	275	138	2:25	1.1	Nitro	T2Kazuya	blossoms	f	T2Kazuya
151	Blossoms	PRS	4	4	383	138	2:25	1.1	Nitro	T2Kazuya	blossoms	f	T2Kazuya
152	Blossoms	FTR	7	7	655	138	2:25	1.1	Nitro	T2Kazuya	blossoms	f	T2Kazuya
153	Moonheart	PST	2	2.5	449	180	2:13	1.1	Toaster	VMWT	moonheart	f	翡乃イスカ
154	Moonheart	PRS	5	5.5	566	180	2:13	1.1	Toaster	VMWT	moonheart	f	翡乃イスカ
155	Moonheart	FTR	8	8.4	947	180	2:13	1.1	Toaster	VMWT	moonheart	f	翡乃イスカ
156	Moonheart	BYD	9+	9.7	1139	180	2:13	3.4	Toaster	VMWT + ljc	moonheart	t	翡乃イスカ
157	Genesis	PST	2	2	275	132	2:13	1.1	Haruba	RiceGnat	genesis	f	Iris
158	Genesis	PRS	5	5.5	399	132	2:13	1.1	Haruba	RiceGnat	genesis	f	Iris
159	Genesis	FTR	8	8.2	713	132	2:13	1.1	Haruba	RiceGnat	genesis	f	Iris
160	Harutopia ~Utopia of Spring~	PST	1	1	444	185	2:20	1.1	トーストピア  ~Utopia of Toast~	\N	harutopia	f	A-zu-ra
161	Harutopia ~Utopia of Spring~	PRS	4	4.5	706	185	2:20	1.1	トーストピア  ~Utopia of Toast~	\N	harutopia	f	A-zu-ra
162	Harutopia ~Utopia of Spring~	FTR	8	8.5	1061	185	2:20	1.1	トーストピア  ~Utopia of Toast~	\N	harutopia	f	A-zu-ra
163	Auxesia	PST	3	3.5	385	183	2:04	1.1	Nitroだー！！	シエラ	auxesia	f	ginkiha
164	Auxesia	PRS	6	6.5	648	183	2:04	1.1	Nitroだー！	シエラ	auxesia	f	ginkiha
165	Auxesia	FTR	9	9.3	1000	183	2:04	1.1	Nitroだー！	シエラ	auxesia	f	ginkiha
166	Rabbit In The Black Room	PST	2	2.5	373	270	2:12	1.1	Toaster	YEONIE	rabbitintheblackroom	f	Rabbit House
167	Rabbit In The Black Room	PRS	5	5.5	467	270	2:12	1.1	Toaster	YEONIE	rabbitintheblackroom	f	Rabbit House
168	Rabbit In The Black Room	FTR	8	8.4	772	270	2:12	1.1	Toaster	YEONIE	rabbitintheblackroom	f	Rabbit House
169	Modelista	PST	3	3.5	418	165	2:07	1.1	NITRO	yusi.	modelista	f	HiTECH NINJA
170	Modelista	PRS	7	7.5	691	165	2:07	1.1	NITRO	yusi.	modelista	f	HiTECH NINJA
171	Modelista	FTR	9+	9.9	1010	165	2:07	1.1	NITRO	yusi.	modelista	f	HiTECH NINJA
172	SOUNDWiTCH	PST	3	3.5	315	170	1:45	1.5	NiTRO	スズカミ	soundwitch	f	HATE
173	SOUNDWiTCH	PRS	6	6.5	488	170	1:45	1.5	NiTRO	スズカミ	soundwitch	f	HATE
174	SOUNDWiTCH	FTR	9+	9.8	785	170	1:45	1.5	NiTRO	スズカミ	soundwitch	f	HATE
175	trappola bewitching	PST	3	3	415	190	2:00	1.5	Kurorak	Shionty	trappola	f	gmtn.
176	trappola bewitching	PRS	6	6	541	190	2:00	1.5	Kurorak	Shionty	trappola	f	gmtn.
177	trappola bewitching	FTR	9+	9.9	1044	190	2:00	1.5	k//urorak	Shionty	trappola	f	gmtn.
178	trappola bewitching	BYD	10	10.6	1086	190	2:00	4.3	NITRO -mesmerize-	Shionty	trappola	t	gmtn.
179	Iconoclast	PST	4	4	443	140	2:06	1.5	Toaster	SKT	iconoclast	f	Yamajet
180	Iconoclast	PRS	7	7	593	140	2:06	1.5	Toaster	SKT	iconoclast	f	Yamajet
181	Iconoclast	FTR	9	9.1	795	140	2:06	1.5	Toaster	SKT	iconoclast	f	Yamajet
182	conflict	PST	4	4.5	520	160	2:08	1.5	Toaster	horte	conflict	f	siromaru + cranky
183	conflict	PRS	7	7.5	731	160	2:08	1.5	Nitro	horte	conflict	f	siromaru + cranky
184	conflict	FTR	10	10.2	1056	160	2:08	1.5	toaster + nitro	horte	conflict	f	siromaru + cranky
185	Axium Crisis	PST	5	5.5	685	170	2:30	1.5	The Monolith	シエラ	axiumcrisis	f	ak+q
186	Axium Crisis	PRS	8	8.5	1065	170	2:30	1.5	The Monolith	シエラ	axiumcrisis	f	ak+q
187	Axium Crisis	FTR	10	10.6	1094	170	2:30	1.5	The Monolith	シエラ	axiumcrisis	f	ak+q
188	Axium Divergence	BYD	11	11.3	1682	170?	2:30	6.13	Monolith - Diverged	すずなし	axiumcrisis	t	ak+q (lowiro)
252	γuarδina	PST	4	4	507	202	2:11	1.6	τoastεr	姐川 + Khronetic	guardina	f	Aoi
189	Grievous Lady	PST	6	6.5	956	210	2:20	1.5	迷路第一層	シエラ	grievouslady	f	Team Grimoire vs Laur
190	Grievous Lady	PRS	9	9.3	1194	210	2:20	1.5	迷路第二層	シエラ	grievouslady	f	Team Grimoire vs Laur
191	Grievous Lady	FTR	11	11.1	1450	210	2:20	1.5	迷路深層	シエラ	grievouslady	f	Team Grimoire vs Laur
192	Dreamin' Attraction!!	PST	4	4.5	592	205	2:19	1.5	Nitro	\N	dreaminattraction	f	翡乃イスカ
193	Dreamin' Attraction!!	PRS	7	7	785	205	2:19	1.5	Nitro	\N	dreaminattraction	f	翡乃イスカ
194	Dreamin' Attraction!!	FTR	9	9.4	1129	205	2:19	1.5	Nitro	\N	dreaminattraction	f	翡乃イスカ
9	GOODTEK (Arcaea Edit)	PST	4	4	449	190	2:06	1.0	Nitro	Koyama Mai	goodtek	f	EBIMAYO
10	GOODTEK (Arcaea Edit)	PRS	6	6.5	632	190	2:06	1.0	Nitro	Koyama Mai	goodtek	f	EBIMAYO
11	GOODTEK (Arcaea Edit)	FTR	9	9.3	968	190	2:06	1.0	Nitro	Koyama Mai	goodtek	f	EBIMAYO
195	Red and Blue	PST	4	4	464	150	1:58	1.5	-chartaesthesia- RED side	Khronetic	redandblue	f	Silentroom
196	Red and Blue	PRS	7+	7.8	597	150	1:58	1.5	side BLUE -chartaesthesia-	Khronetic	redandblue	f	Silentroom
197	Red and Blue	FTR	9	9.4	845	150	1:58	1.5	-chartaesthesia-\nLEFT=BLUE RED=RIGHT 	Khronetic	redandblue	f	Silentroom
198	Red and Blue	BYD	10	10.2	1194	160	1:58	3.12	moonquay "retrograde"\nBLUE=LEFT RIGHT=RED	yusi.	redandblue	t	fn(ArcaeaSoundTeam)
199	One Last Drive	PST	2	2.5	604	154 - 175	2:24	1.5	Toaster	\N	onelastdrive	f	REDSHiFT
200	One Last Drive	PRS	5	5.5	564	154 - 175	2:24	1.5	Toaster	\N	onelastdrive	f	REDSHiFT
201	One Last Drive	FTR	8	8.2	885	154 - 175	2:24	1.5	Toaster	\N	onelastdrive	f	REDSHiFT
202	Surrender	PST	3	3	550	152	2:27	1.5	Nitro	softmode	surrender	f	void
203	Surrender	PRS	6	6.5	721	152	2:27	1.5	Nitro	softmode	surrender	f	void
204	Surrender	FTR	8+	8.8	925	152	2:27	1.5	Nitro	softmode	surrender	f	void
205	Yosakura Fubuki	PST	4	4.5	416	172	2:14	1.5	k//eternal	シエラ	yozakurafubuki	f	A.SAKA
206	Yosakura Fubuki	PRS	7	7	582	172	2:14	1.5	k//eternal	シエラ	yozakurafubuki	f	A.SAKA
207	Yosakura Fubuki	FTR	9	9.4	931	172	2:14	1.5	k//eternal	シエラ	yozakurafubuki	f	A.SAKA
208	cyanine	PST	4	4	661	182	2:30	1.5	夜浪 - Apocalypse	\N	cyanine	f	jioyi
209	cyanine	PRS	7+	7.8	947	182	2:30	1.5	夜浪	\N	cyanine	f	jioyi
210	cyanine	FTR	10	10.6	1171	182	2:30	1.5	夜浪	\N	cyanine	f	jioyi
211	Dream goes on	PST	1	1.5	532	174	2:25	1.5	k//eternal	\N	dreamgoeson	f	Tiny Minim
212	Dream goes on	PRS	5	5	751	174	2:25	1.5	k//eternal	\N	dreamgoeson	f	Tiny Minim
213	Dream goes on	FTR	7+	7.8	719	174	2:25	1.5	k//eternal	\N	dreamgoeson	f	Tiny Minim
214	Journey	PST	3	3	551	200	2:13	1.5	Kurorak	\N	journey	f	ARForest
215	Journey	PRS	6	6	778	200	2:13	1.5	Kurorak	\N	journey	f	ARForest
216	Journey	FTR	9	9.1	997	200	2:13	1.5	Kurorak	\N	journey	f	ARForest
217	Specta	PST	3	3.5	390	179	2:16	1.5	Toaster	\N	specta	f	Junk
218	Specta	PRS	6	6.5	706	179	2:16	1.5	Toaster	\N	specta	f	Junk
219	Specta	FTR	9	9.4	1096	179	2:16	1.5	Toaster	\N	specta	f	Junk
220	Quon	PST	4	4	547	189	2:23	1.5	Nitro	シエラ	quon	f	Feryquitous
221	Quon	PRS	6	6.5	718	189	2:23	1.5	Nitro	シエラ	quon	f	Feryquitous
222	Quon	FTR	9	9.6	991	189	2:23	1.5	Nitro	シエラ	quon	f	Feryquitous
223	Syro	PST	3	3.5	535	178	2:20	1.5	Toaster	RiceGnat	syro	f	Mitomoro
224	Syro	PRS	6	6.5	829	178	2:20	1.5	Toaster	RiceGnat	syro	f	Mitomoro
225	Syro	FTR	9	9.3	1150	178	2:20	1.5	Toaster	RiceGnat	syro	f	Mitomoro
226	Reinvent	PST	2	2.5	570	174	2:24	1.5	k//eternal	Khronetic	reinvent	f	Sound Souler
227	Reinvent	PRS	6	6.5	703	174	2:24	1.5	k//eternal	Khronetic	reinvent	f	Sound Souler
228	Reinvent	FTR	8	8.5	852	174	2:24	1.5	k//eternal + nitro	Khronetic	reinvent	f	Sound Souler
229	Silent Rush	PST	2	2.5	416	158	2:34	1.6	TaroNuke	CinEraLiA	silentrush	f	Soleily
230	Silent Rush	PRS	5	5	674	158	2:34	1.6	TaroNuke	CinEraLiA	silentrush	f	Soleily
231	Silent Rush	FTR	8	8.6	941	158	2:34	1.6	TaroNuke	CinEraLiA	silentrush	f	Soleily
232	Singularity	PST	4	4.5	534	175	2:06	1.6	東星	シエラ	singularity	f	ETIA.
233	Singularity	PRS	7+	7.8	678	175	2:06	1.6	東星	シエラ	singularity	f	ETIA.
234	Singularity	FTR	10	10.5	1105	175	2:06	1.6	東星※コラプサー	シエラ	singularity	f	ETIA.
235	Singularity VVVIP	BYD	10	10.4	1114	175	2:06	3.12	Exschwasion against. 絶滅	yusi.	singularity	t	Arcaea Sound Team against. ETIA.
236	Memory Forest	PST	3	3.5	639	178	2:24	1.6	Kurorak	シエラ	memoryforest	f	ETIA.
237	Memory Forest	PRS	6	6	726	178	2:24	1.6	Kurorak	シエラ	memoryforest	f	ETIA.
238	Memory Forest	FTR	9+	9.8	978	178	2:24	1.6	Kurorak	シエラ	memoryforest	f	ETIA.
239	Strongholds	PST	2	2.5	570	105	2:13	1.6	TaroNuke	八葉	strongholds	f	Yooh
240	Strongholds	PRS	5	5	778	105	2:13	1.6	TaroNukeΔ	八葉	strongholds	f	Yooh
241	Strongholds	FTR	9	9.2	922	105	2:13	1.6	TΔroNuke	八葉	strongholds	f	Yooh
242	next to you	PST	4	4.5	454	165	2:12	1.6	Nitro	mins	nexttoyou	f	uma feat. 橘花音
243	next to you	PRS	7	7	583	165	2:12	1.6	Nitro	mins	nexttoyou	f	uma feat. 橘花音
244	next to you	FTR	8+	8.8	824	165	2:12	1.6	Nitro	mins	nexttoyou	f	uma feat. 橘花音
245	next to you	BYD	9	9.6	954	165	2:12	3.6	Toastie	mins	nexttoyou	t	uma feat. 橘花音
246	Metallic Punisher	PST	3	3	500	165	2:24	1.5	Kurorak	nonokuro	metallicpunisher	f	INNOCENT NOIZE
247	Metallic Punisher	PRS	7	7	846	165	2:24	1.5	Kurorak	nonokuro	metallicpunisher	f	INNOCENT NOIZE
248	Metallic Punisher	FTR	10	10.3	1238	165	2:24	1.5	Black Tea	nonokuro	metallicpunisher	f	INNOCENT NOIZE
249	Blaster	PST	4	4	571	180	2:17	1.5	k//urorak	LAM	blaster	f	Massive New Krew
12	GOODTEK (Arcaea Edit)	BYD	9+	9.8	1103	190	2:06	3.0	GOODTOAST	出前	goodtek	t	EBIMAYO
13	cry of viyella	PST	3	3.5	414	75 - 180	2:07	1.0	Toaster	Khronetic	viyella	f	Laur
14	cry of viyella	PRS	6	6	492	75 - 180	2:07	1.0	Toaster	Khronetic	viyella	f	Laur
15	cry of viyella	FTR	8+	8.7	791	75 - 180	2:07	1.0	Toaster	Khronetic	viyella	f	Laur
250	Blaster	PRS	7	7	635	180	2:17	1.5	k//urorak	LAM	blaster	f	Massive New Krew
251	Blaster	FTR	9	9.3	1002	180	2:17	1.5	k//urorak	LAM	blaster	f	Massive New Krew
253	γuarδina	PRS	8	8	678	202	2:11	1.6	τoastεr	姐川 + Khronetic	guardina	f	Aoi
254	γuarδina	FTR	10	10.4	1120	202	2:11	1.6	τoastεr	姐川 + Khronetic	guardina	f	Aoi
255	carmine:scythe	PST	4	4	493	165	2:21	1.6	週刊Toaster	未早	carminescythe	f	かゆき
256	carmine:scythe	PRS	7+	7.8	710	165	2:21	1.6	週刊Toaster	未早	carminescythe	f	かゆき
257	carmine:scythe	FTR	9	9.6	1164	165	2:21	1.6	週刊Toaster	未早	carminescythe	f	かゆき
259	Be There	PRS	7	7.5	792	164	2:11	1.6	Nitro	hie	bethere	f	PSYQUI
260	Be There	FTR	9	9.4	982	164	2:11	1.6	Be Nitro	hie	bethere	f	PSYQUI
261	Be There	BYD	10	10.5	1127	164	2:11	6.13	BE KARAT	のう + Khronetic	bethere	t	PSYQUI
262	Cybernecia Catharsis	PST	4	4	377	184	2:10	1.6	Kero	mirimo	cyberneciacatharsis	f	Tanchiky
263	Cybernecia Catharsis	PRS	7	7	655	184	2:10	1.6	Kero	mirimo	cyberneciacatharsis	f	Tanchiky
264	Cybernecia Catharsis	FTR	9	9.5	946	184	2:10	1.6	Kero + Nitro	mirimo	cyberneciacatharsis	f	Tanchiky
265	Cybernecia Catharsis	BYD	9+	9.8	991	184	2:10	5.3	antymis	mirimo	cyberneciacatharsis	t	Tanchiky
266	Call My Name feat. Yukacco	PST	3	3.5	591	175	2:28	1.6	Kurorak	DJ Poyoshi	callmyname	f	Mameyudoufu
267	Call My Name feat. Yukacco	PRS	6	6	653	175	2:28	1.6	Kurorak	DJ Poyoshi	callmyname	f	Mameyudoufu
268	Call My Name feat. Yukacco	FTR	8+	8.7	921	175	2:28	1.6	Kuro my Nitro	DJ Poyoshi	callmyname	f	Mameyudoufu
269	inkar-usi	PST	2	2	276	102	2:23	1.6	Kurorak	Ancy	inkarusi	f	DIA
270	inkar-usi	PRS	4	4	326	102	2:23	1.6	Kurorak	Ancy	inkarusi	f	DIA
271	inkar-usi	FTR	7+	7.8	463	102	2:23	1.6	Kurorak	Ancy	inkarusi	f	DIA
272	inkar-usi	BYD	9	9.4	857	102	2:23	5.3	CERiNG	Ancy	inkarusi	t	DIA
273	Maze No.9	PST	3	3	494	159	2:25	1.7	小東星	アリスシャッハと魔法の楽団	mazenine	f	アリスシャッハと魔法の楽団
274	Maze No.9	PRS	3	3.5	445	159	2:25	1.7	小東星	アリスシャッハと魔法の楽団	mazenine	f	アリスシャッハと魔法の楽団
275	Maze No.9	FTR	8+	8.9	775	159	2:25	1.7	小東星	アリスシャッハと魔法の楽団	mazenine	f	アリスシャッハと魔法の楽団
276	The Message	PST	3	3	536	202	2:20	1.7	Toaster	Shionty + Khronetic	themessage	f	Jun Kuroda
277	The Message	PRS	6	6.5	630	202	2:20	1.7	Toaster	Shionty + Khronetic	themessage	f	Jun Kuroda
278	The Message	FTR	9+	9.7	992	202	2:20	1.7	Toaster	Shionty + Khronetic	themessage	f	Jun Kuroda
279	Sulfur	PST	4	4	458	182	2:19	1.7	Shirorak	すずなし	sulfur	f	ぺのれり
280	Sulfur	PRS	6	6	608	182	2:19	1.7	Shirorak	すずなし	sulfur	f	ぺのれり
281	Sulfur	FTR	9+	9.7	1045	182	2:19	1.7	Shirorak	すずなし	sulfur	f	ぺのれり
282	Halcyon	PST	5	5.5	662	191	2:38	1.7	東星※太陽	\N	halcyon	f	xi
283	Halcyon	PRS	8	8.2	943	191	2:38	1.7	東星※太陽	\N	halcyon	f	xi
284	Halcyon	FTR	10	10.5	1227	191	2:38	1.7	東星※太陽	\N	halcyon	f	xi
285	Ether Strike	PST	5	5.5	659	156	2:19	1.7	Zero Sky	シエラ	etherstrike	f	Akira Complex
286	Ether Strike	PRS	8	8.3	837	156	2:19	1.7	Zero Sky	シエラ	etherstrike	f	Akira Complex
287	Ether Strike	FTR	10	10.3	1170	156	2:19	1.7	Zero Sky	シエラ	etherstrike	f	Akira Complex
288	Fracture Ray	PST	6	6	983	200	2:33	1.7	Volatile Paradox	シエラ	fractureray	f	Sakuzyo
289	Fracture Ray	PRS	9	9.5	1343	200	2:33	1.7	Absolute Paradox	シエラ	fractureray	f	Sakuzyo
290	Fracture Ray	FTR	11	11.1	1279	200	2:33	1.7	Paradox Zero	シエラ	fractureray	f	Sakuzyo
291	Suomi	PST	2	2	368	125	2:08	1.7	Toastie	雨風雪夏	suomi	f	Aire
292	Suomi	PRS	5	5	550	125	2:08	1.7	Toastie	雨風雪夏	suomi	f	Aire
293	Suomi	FTR	7+	7.8	818	125	2:08	1.7	Toastie	雨風雪夏	suomi	f	Aire
294	Suomi	ETR	8+	8.9	732	125	2:08	5.4	CERiNG	雨風雪夏	suomi	f	Aire
295	Bookmaker (2D Version)	PST	4	4.5	538	175	2:29	1.7	Kurorak	窓壁九真好キ	bookmaker	f	Kobaryo
296	Bookmaker (2D Version)	PRS	6	6.5	728	175	2:29	1.7	Kurorak	窓壁九真好キ	bookmaker	f	Kobaryo
297	Bookmaker (2D Version)	FTR	8	8.3	1124	175	2:29	1.7	Kurorak	窓壁九真好キ	bookmaker	f	Kobaryo
298	Bookmaker (2D Version)	BYD	10	10	1287	175	2:29	3.6	Toastmaker	窓壁九真好キ	bookmaker	t	Kobaryo
299	Illegal Paradise	PST	2	2	535	168	2:34	1.7	k//eternal	Illegal Khronetic	darakunosono	f	gmtn. (witch's slave)
300	Illegal Paradise	PRS	7	7	585	168	2:34	1.7	k//eternal	Illegal Khronetic	darakunosono	f	gmtn. (witch's slave)
16	Rise	PST	2	2.5	322	140	2:21	1.0	Nitro	\N	rise	f	Combatplayer
17	Rise	PRS	4	4	599	140	2:21	1.0	Nitro	\N	rise	f	Combatplayer
18	Rise	FTR	7+	7.8	788	140	2:21	1.0	Nitro	\N	rise	f	Combatplayer
301	Illegal Paradise	FTR	9	9.5	1061	168	2:34	1.7	k//eternal + nitro	Illegal Khronetic	darakunosono	f	gmtn. (witch's slave)
302	dropdead	PST	1	1.5	44	50	2:16	1.7	-chartaesthesia-\nLIMITER:10%	Hanamori Hiro	dropdead	f	Frums
303	dropdead	PRS	9	9.5	1323	50	2:16	1.7	-chartaesthesia-\nLIMITER:100%	Hanamori Hiro	dropdead	f	Frums
304	dropdead	FTR	8+	9.1	823	50	2:16	1.7	-chartaesthesia-\nLIMITER:25% (OVERDRIVE:+100%)	Hanamori Hiro	dropdead	f	Frums
305	overdead.	BYD	10	10.5	1503	500	2:16	3.12	絶滅 over 夜浪.	Hanamori Hiro + yusi.	dropdead	t	fn
306	Fallensquare	PST	3	3	316	99	2:30	1.7	Haruba	unKn	fallensquare	f	Silentroom
307	Fallensquare	PRS	7	7.5	486	99	2:30	1.7	Haruba	unKn	fallensquare	f	Silentroom
308	Fallensquare	FTR	9+	9.7	703	99	2:30	1.7	Haruba	unKn	fallensquare	f	Silentroom
309	Nhelv	PST	3	3	647	174.59	2:41	1.7	Nitro「Katastrophe」	駿	nhelv	f	Silentroom
310	Nhelv	PRS	6	6.5	913	174.59	2:41	1.7	Nitro「Katastrophe」	駿	nhelv	f	Silentroom
311	Nhelv	FTR	9+	9.9	1108	174.59	2:41	1.7	Nitro「Katastrophe」	駿	nhelv	f	Silentroom
312	Nhelv	BYD	10+	10.9	1474	174.59	2:41	6.4	零下 -descent-	shun yamaguchi	nhelv	t	Silentroom
431	AI[UE]OON	PST	3	3.5	436	145	2:22	2.3	N[I]TRO	SiNoe	aiueoon	f	MYUKKE.
313	LunarOrbit -believe in the Espebranch road-	PST	3	3.5	624	192	2:21	1.7	月刊Toaster	hideo	espebranch	f	Apo11o program ft. 大瀬良あい
314	LunarOrbit -believe in the Espebranch road-	PRS	6	6	757	192	2:21	1.7	月刊Toaster	hideo	espebranch	f	Apo11o program ft. 大瀬良あい
315	LunarOrbit -believe in the Espebranch road-	FTR	9	9.6	1058	192	2:21	1.7	月刊Toaster	hideo	espebranch	f	Apo11o program ft. 大瀬良あい
316	Purgatorium	PST	2	2.5	609	150	2:29	1.7	Kurorak	michele	purgatorium	f	お月さま交響曲
317	Purgatorium	PRS	6	6	641	150	2:29	1.7	Kurorak	michele	purgatorium	f	お月さま交響曲
318	Purgatorium	FTR	8	8.4	983	150	2:29	1.7	Kurorak	michele	purgatorium	f	お月さま交響曲
319	Purgatorium	BYD	9	9.6	1051	150	2:29	3.1	Toaster	michele	purgatorium	t	お月さま交響曲
320	Hikari	PST	2	2.5	237	130	2:18	1.8	OptoNuke	\N	hikari	f	THB
321	Hikari	PRS	6	6	450	130	2:18	1.8	OptoNuke	\N	hikari	f	THB
322	Hikari	FTR	8	8.1	684	130	2:18	1.8	OptoNuke	\N	hikari	f	THB
323	STAGER (ALL STAGE CLEAR)	PST	3	3	453	145	2:26	1.8	KURORAK	\N	stager	t	Ras
324	STAGER (ALL STAGE CLEAR)	PRS	6	6.5	559	145	2:26	1.8	KURORAK	\N	stager	t	Ras
325	STAGER (ALL STAGE CLEAR)	FTR	9	9.5	1004	145	2:26	1.8	KURORAK	\N	stager	f	Ras
326	Hall of Mirrors	PST	3	3	535	147	2:33	1.8	Toaster	\N	hallofmirrors	f	Sta
327	Hall of Mirrors	PRS	5	5.5	553	147	2:33	1.8	Toaster	\N	hallofmirrors	f	Sta
328	Hall of Mirrors	FTR	8	8.2	898	147	2:33	1.8	Toaster	\N	hallofmirrors	f	Sta
329	Linear Accelerator	PST	2	2.5	438	200 - 211.9	2:01	1.8	THE TOAST	\N	linearaccelerator	f	THE SHAFT
330	Linear Accelerator	PRS	6	6.5	488	200 - 211.9	2:01	1.8	THE TOAST	\N	linearaccelerator	f	THE SHAFT
331	Linear Accelerator	FTR	9+	9.8	905	200 - 211.9	2:01	1.8	THE TOAST	\N	linearaccelerator	f	THE SHAFT
332	Tiferet	PST	4	4.5	450	140?	2:24	1.8	夜浪[Spherical]	\N	tiferet	f	xi + Sta
333	Tiferet	PRS	7+	7.8	720	140?	2:24	1.8	夜浪[Spherical]	\N	tiferet	f	xi + Sta
334	Tiferet	FTR	10	10.3	1086	140?	2:24	1.8	夜浪[Spherical]	\N	tiferet	f	xi + Sta
335	Alexandrite	PST	4	4.5	507	146	2:19	1.7	東星※空の宝石	シエラ	alexandrite	f	WAiKURO
336	Alexandrite	PRS	7	7.5	699	146	2:19	1.7	東星※空の宝石	シエラ	alexandrite	f	WAiKURO
337	Alexandrite	FTR	10	10	1040	146	2:19	1.7	東星※空の宝石	シエラ	alexandrite	f	WAiKURO
338	Rugie	PST	3	3	566	191	2:24	1.8	k//urorak	\N	rugie	f	Feryquitous feat.Sennzai
339	Rugie	PRS	6	6	754	191	2:24	1.8	k//urorak	\N	rugie	f	Feryquitous feat.Sennzai
340	Rugie	FTR	9	9.2	975	191	2:24	1.8	k//urorak	\N	rugie	f	Feryquitous feat.Sennzai
341	Astral tale	PST	4	4.5	445	134	2:28	1.8	Nitro	岩十	astraltale	f	Noah
342	Astral tale	PRS	7	7	642	134	2:28	1.8	Nitro	岩十	astraltale	f	Noah
343	Astral tale	FTR	9	9.6	884	134	2:28	1.8	Nitro	岩十	astraltale	f	Noah
344	Phantasia	PST	4	4	544	153	2:32	1.8	Toaster	そゐち	phantasia	f	Yunosuke
345	Phantasia	PRS	5	5.5	579	153	2:32	1.8	Toaster	そゐち	phantasia	f	Yunosuke
346	Phantasia	FTR	9	9.2	952	153	2:32	1.8	Toaster	そゐち	phantasia	f	Yunosuke
347	Empire of Winter	PST	3	3.5	484	175	2:19	1.8	0°Nitro	シエラ + Khronetic	empireofwinter	f	Street
348	Empire of Winter	PRS	6	6.5	662	175	2:19	1.8	0°Nitro	シエラ + Khronetic	empireofwinter	f	Street
349	Empire of Winter	FTR	9	9.1	920	175	2:19	1.8	0°Nitro	シエラ + Khronetic	empireofwinter	f	Street
350	MERLIN	PST	3	3	315	180	2:09	1.9	Got More Taro?	\N	merlin	f	REDALiCE
351	MERLIN	PRS	5	5.5	428	180	2:09	1.9	Got More Taro?	\N	merlin	f	REDALiCE
352	MERLIN	FTR	8+	8.9	712	180	2:09	1.9	Got More Taro?	\N	merlin	f	REDALiCE
353	MERLIN	BYD	9	9.4	881	180	2:09	3.12	EXSCHWASiON	\N	merlin	f	REDALiCE
19	Lucifer	PST	3	3.5	424	165	2:13	1.0	Nitro	\N	lucifer	f	chitose
20	Lucifer	PRS	5	5.5	506	165	2:13	1.0	Nitro	\N	lucifer	f	chitose
21	Lucifer	FTR	8	8.2	861	165	2:13	1.0	Nitro	\N	lucifer	f	chitose
22	Fairytale	PST	1	1	336	189	2:10	1.0	Toaster	Khronetic	fairytale	f	chitose
354	DX Choseinou Full Metal Shojo	PST	3	3	327	160	1:55	1.9	DX譜面作者フルメタルNitro	\N	dxfullmetal	f	IOSYS TRAX (uno with.ちよこ)
355	DX Choseinou Full Metal Shojo	PRS	6	6	556	160	1:55	1.9	DX譜面作者フルメタルNitro	\N	dxfullmetal	f	IOSYS TRAX (uno with.ちよこ)
356	DX Choseinou Full Metal Shojo	FTR	9+	9.7	808	160	1:55	1.9	DX譜面作者フルメタルNitro	\N	dxfullmetal	f	IOSYS TRAX (uno with.ちよこ)
357	OMAKENO Stroke	PST	3	3	502	240	1:56	1.9	Kurorak	\N	omakeno	f	t+pazolite
358	OMAKENO Stroke	PRS	6	6.5	616	240	1:56	1.9	Kurorak	\N	omakeno	f	t+pazolite
359	OMAKENO Stroke	FTR	9	9.5	869	240	1:56	1.9	Kurorak	\N	omakeno	f	t+pazolite
360	OMAKENO Stroke	BYD	10	10.3	931	240	1:56	3.12	NITRO	\N	omakeno	f	t+pazolite
361	Scarlet Lance	PST	4	4	517	185	2:09	1.9	闇運	\N	scarletlance	f	MASAKI (ZUNTATA)
362	Scarlet Lance	PRS	7	7	644	185	2:09	1.9	闇運	\N	scarletlance	f	MASAKI (ZUNTATA)
363	Scarlet Lance	FTR	10	10	1130	185	2:09	1.9	闇運	\N	scarletlance	f	MASAKI (ZUNTATA)
364	ouroboros -twin stroke of the end-	PST	4	4.5	575	188	2:29	1.9	Groove 東星	\N	ouroboros	f	Cranky VS MASAKI
365	ouroboros -twin stroke of the end-	PRS	7	7.5	832	188	2:29	1.9	Groove 東星	\N	ouroboros	f	Cranky VS MASAKI
366	ouroboros -twin stroke of the end-	FTR	10+	10.7	1369	188	2:29	1.9	Groove 東星	\N	ouroboros	f	Cranky VS MASAKI
367	Libertas	PST	3	3.5	476	160	2:11	1.9	Kurorak	wacca	libertas	f	Zekk
368	Libertas	PRS	5	5.5	514	160	2:11	1.9	Kurorak	wacca	libertas	f	Zekk
369	Libertas	FTR	9	9.2	947	160	2:11	1.9	Kurorak + Nitro	wacca	libertas	f	Zekk
370	Libertas	BYD	10	10.5	1048	160	2:11	5.3	Exschwasion -unbound-	wacca	libertas	t	Zekk
371	Solitary Dream	PST	4	4	712	162	2:53	1.9	\N	シエラ	solitarydream	f	ak+q feat. Sennzai
372	Solitary Dream	PRS	7	7	854	162	2:53	1.9	\N	シエラ	solitarydream	f	ak+q feat. Sennzai
373	Solitary Dream	FTR	8+	8.8	972	162	2:53	1.9	\N	シエラ	solitarydream	f	ak+q feat. Sennzai
374	Antithese	PST	2	2	845	172	2:20	2.0	chaos//engine	釜飯轟々丸 + Khronetic	antithese	f	Blacklolita
375	Antithese	PRS	5	5	826	172	2:20	2.0	chaos//engine	釜飯轟々丸 + Khronetic	antithese	f	Blacklolita
376	Antithese	FTR	8+	8.8	877	172	2:20	2.0	chaos//engine	釜飯轟々丸 + Khronetic	antithese	f	Blacklolita
377	Antithese	BYD	9	9.6	968	172	2:20	3.10	石樂	釜飯轟々丸 + jht	antithese	t	Blacklolita
378	Corruption	PST	3	3	664	170	2:25	2.0	₸öα$†ε₹	BerryVerrine	corruption	f	3R2
379	Corruption	PRS	6	6.5	847	170	2:25	2.0	₸öα$†ε₹	BerryVerrine	corruption	f	3R2
380	Corruption	FTR	9+	9.8	1293	170	2:25	2.0	₸öα$†ε₹	BerryVerrine	corruption	f	3R2
381	Black Territory	PST	3	3	627	200	2:19	2.0	NitroNukeδ	トロ３	blackterritory	f	DJ Myosuke
382	Black Territory	PRS	7	7.5	785	200	2:19	2.0	NitroNukeδ	トロ３	blackterritory	f	DJ Myosuke
383	Black Territory	FTR	9+	9.8	1195	200	2:19	2.0	NitroNukeδ	トロ３	blackterritory	f	DJ Myosuke
384	Vicious Heroism	PST	4	4	430	256	2:20	2.0	Nitro vanquish Toaster.	吠L	viciousheroism	f	Kobaryo
385	Vicious Heroism	PRS	7	7.5	756	256	2:20	2.0	Nitro vanquish Toaster.	吠L	viciousheroism	f	Kobaryo
386	Vicious Heroism	FTR	10	10	1150	256	2:20	2.0	Nitro vanquish Toaster.	吠L	viciousheroism	f	Kobaryo
387	Vicious [ANTi] Heroism	BYD	11	11.2	1772	271	2:20	5.3	[FUTiLE] Defiance	陽葉ヨウ	viciousheroism	t	Kobaryo
388	Cyaegha	PST	5	5.5	760	200	2:21	2.0	夜浪、旧支配者	シエラ	cyaegha	f	USAO
389	Cyaegha	PRS	8	8.4	984	200	2:21	2.0	夜浪、旧支配者	シエラ	cyaegha	f	USAO
390	Cyaegha	FTR	10+	10.7	1368	200	2:21	2.0	夜浪、旧支配者	シエラ	cyaegha	f	USAO
391	ReviXy	PST	3	3	538	115-185	2:38	2.0	Revoke Kurorak	出前	revixy	f	ikaruga_nex
392	ReviXy	PRS	7	7	729	115-185	2:38	2.0	Revoke Kurorak	出前	revixy	f	ikaruga_nex
393	ReviXy	FTR	9	9.1	1047	115-185	2:38	2.0	Revoke Kurorak	出前	revixy	f	ikaruga_nex
395	Grimheart	PRS	5	5	699	170	2:30	2.0	Toaster	\N	grimheart	f	Puru
396	Grimheart	FTR	8+	8.7	959	170	2:30	2.0	Toaster	\N	grimheart	f	Puru
397	VECTOЯ	PST	3	3	675	200	2:21	2.0	Nitro	ふぇいフリック	vector	f	WHITEFISTS
398	VECTOЯ	PRS	7	7	1002	200	2:21	2.0	Nitro	ふぇいフリック	vector	f	WHITEFISTS
399	VECTOЯ	FTR	9	9.4	1299	200	2:21	2.0	Nitro	ふぇいフリック	vector	f	WHITEFISTS
400	SUPERNOVA	PST	3	3	664	150	2:38	2.0	東超新星	Khronetic	supernova	f	BACO
401	SUPERNOVA	PRS	6	6	564	150	2:38	2.0	東超新星	Khronetic	supernova	f	BACO
402	SUPERNOVA	FTR	9+	9.7	1123	150	2:38	2.0	東超新星	Khronetic	supernova	f	BACO
403	Dot to Dot feat. shully	PST	3	3	453	174	2:11	2.0	•Nitro•	DJ Poyoshi	dottodot	f	Mameyudoufu
23	Fairytale	PRS	3	3.5	511	189	2:10	1.0	Toaster	Khronetic	fairytale	f	chitose
24	Fairytale	FTR	7	7	782	189	2:10	1.0	Toaster	Khronetic	fairytale	f	chitose
25	Fairytale	BYD	9	9.5	932	189	2:10	3.0	Nitro in Wonderland	Khronetic	fairytale	t	chitose
404	Dot to Dot feat. shully	PRS	6	6	522	174	2:11	2.0	•Nitro•	DJ Poyoshi	dottodot	f	Mameyudoufu
405	Dot to Dot feat. shully	FTR	8	8.3	739	174	2:11	2.0	•Nitro•	DJ Poyoshi	dottodot	f	Mameyudoufu
406	Garakuta Doll Play	PST	4	4.5	444	256	2:08	2.1	Arcaea Charting Team【Royal Flush】	\N	garakuta	f	t+pazolite
407	Garakuta Doll Play	PRS	6	6.5	572	256	2:08	2.1	Arcaea Charting Team【Royal Flush】	\N	garakuta	f	t+pazolite
408	Garakuta Doll Play	FTR	10	10.4	1035	256	2:08	2.1	Arcaea Charting Teamからの挑戦状 	\N	garakuta	f	t+pazolite
409	Ikazuchi	PST	3	3.5	656	200	2:30	2.1	先史の機械神【夜浪】	\N	ikazuchi	f	光吉猛修
410	Ikazuchi	PRS	7	7.5	976	200	2:30	2.1	先史の機械神【夜浪】	\N	ikazuchi	f	光吉猛修
411	Ikazuchi	FTR	10	10.3	1347	200	2:30	2.1	先史の機械神【夜浪】	\N	ikazuchi	f	光吉猛修
412	World Vanquisher	PST	2	2.5	529	170	2:45	2.1	処刑人【東星】	\N	worldvanquisher	f	void (Mournfinale)
413	World Vanquisher	PRS	5	5.5	759	170	2:45	2.1	処刑人【東星】	\N	worldvanquisher	f	void (Mournfinale)
414	World Vanquisher	FTR	10+	10.7	1452	170	2:45	2.1	処刑人【東星】	\N	worldvanquisher	f	void (Mournfinale)
415	Dreadnought	PST	4	4	715	96-384	2:20	2.2	Nitro	\N	dreadnought	f	Mastermind (xi + nora2r)
416	Dreadnought	PRS	7	7	897	96-384	2:20	2.2	Nitro	\N	dreadnought	f	Mastermind (xi + nora2r)
417	Dreadnought	FTR	9+	9.7	1099	96-384	2:20	2.2	Astronomer (Toaster + 東星)	\N	dreadnought	f	Mastermind (xi + nora2r)
418	Vindication	PST	4	4	721	174	2:29	2.2	Toaster	EB十	vindication	f	Laur
419	Vindication	PRS	6	6.5	899	174	2:29	2.2	Toaster	EB十	vindication	f	Laur
420	Vindication	FTR	9	9.6	1075	174	2:29	2.2	Nitro vs Toaster	EB十	vindication	f	Laur
421	Heavensdoor	PST	4	4.5	766	240	2:11	2.2	Kurorak	yusi. + Khronetic	heavensdoor	f	LeaF
422	Heavensdoor	PRS	7	7.5	869	240	2:11	2.2	Kurorak	yusi. + Khronetic	heavensdoor	f	LeaF
423	Heavensdoor	FTR	9+	9.9	1101	240	2:11	2.2	Black Tea	yusi. + Khronetic	heavensdoor	f	LeaF
424	Heavensdoor	BYD	10+	10.8	1534	240	2:11	3.10	東星※天の門	nonokuro	heavensdoor	t	LeaF
425	Ringed Genesis	PST	5	5.5	672	160	2:13	2.2	夜浪 vs Nitro	シエラ	ringedgenesis	f	Edelritter
426	Ringed Genesis	PRS	8	8.4	860	160	2:13	2.2	夜浪 vs Nitro	シエラ	ringedgenesis	f	Edelritter
427	Ringed Genesis	FTR	10+	10.8	1146	160	2:13	2.2	夜浪 vs Nitro	シエラ	ringedgenesis	f	Edelritter
428	Chelsea	PST	3	3	388	174	2:09	2.3	TaroNuke	Refla	chelsea	f	7mai
429	Chelsea	PRS	6	6	503	174	2:09	2.3	TaroNuke	Refla	chelsea	f	7mai
430	Chelsea	FTR	8+	8.9	650	174	2:09	2.3	TaroNuke	Refla	chelsea	f	7mai
432	AI[UE]OON	PRS	6	6.5	623	145	2:22	2.3	N[I]TRO	SiNoe	aiueoon	f	MYUKKE.
433	AI[UE]OON	FTR	9	9.4	989	145	2:22	2.3	N[I]TRO	SiNoe	aiueoon	f	MYUKKE.
434	A Wandering Melody of Love	PST	3	3.5	422	165	2:13	2.3	恋のToaster	シエラ	melodyoflove	f	からとPαnchii少年 feat.はるの
435	A Wandering Melody of Love	PRS	7	7.5	670	165	2:13	2.3	恋のToaster	シエラ	melodyoflove	f	からとPαnchii少年 feat.はるの
436	A Wandering Melody of Love	FTR	9	9.6	931	165	2:13	2.3	恋のToaster	シエラ	melodyoflove	f	からとPαnchii少年 feat.はるの
437	Tie me down gently	PST	3	3	581	191	2:19	2.3	Kurorak	kobuta	tiemedowngently	f	溝口ゆうま feat. 大瀬良あい
438	Tie me down gently	PRS	5	5.5	535	191	2:19	2.3	Kurorak	kobuta	tiemedowngently	f	溝口ゆうま feat. 大瀬良あい
439	Tie me down gently	FTR	8	8.3	724	191	2:19	2.3	Kurorak	kobuta	tiemedowngently	f	溝口ゆうま feat. 大瀬良あい
440	Valhalla:0	PST	4	4.5	624	200	2:22	2.3	夜浪	すずなし	valhallazero	f	Juggernaut.
441	Valhalla:0	PRS	7	7.5	893	200	2:22	2.3	夜浪	すずなし	valhallazero	f	Juggernaut.
442	Valhalla:0	FTR	10	10.2	1173	200	2:22	2.3	夜浪	すずなし	valhallazero	f	Juggernaut.
443	Mirzam	PST	4	4	662	201	2:28	2.3	東星※おおいぬ座β星	すずなし	mirzam	f	Aoi vs. siqlo
444	Mirzam	PRS	7	7.5	885	201	2:28	2.3	東星※おおいぬ座β星	すずなし	mirzam	f	Aoi vs. siqlo
445	Mirzam	FTR	9+	9.9	1303	201	2:28	2.3	東星※おおいぬ座β星	すずなし	mirzam	f	Aoi vs. siqlo
447	Diode	PRS	5	5.5	472	132	2:20	2.4	Kurorak	キッカイキ	diode	f	Kolaa
448	Diode	FTR	8	8.1	709	132	2:20	2.4	Kurorak	キッカイキ	diode	f	Kolaa
449	FREEF4LL	PST	4	4	589	170	2:32	2.4	N↓TRO	きらばがに	freefall	f	YUKIYANAGI
450	FREEF4LL	PRS	7	7	782	170	2:32	2.4	N↓TRO	きらばがに	freefall	f	YUKIYANAGI
451	FREEF4LL	FTR	8	8.6	1023	170	2:32	2.4	N↓TRO	きらばがに	freefall	f	YUKIYANAGI
452	FREEF4LL	BYD	9+	9.8	1336	170	2:32	4.1	TO4STER	きらばがに	freefall	t	YUKIYANAGI
453	GLORY：ROAD	PST	4	4.5	868	250	2:24	2.4	東星※紅空	シエラ	gloryroad	f	uma vs. モリモリあつし
454	GLORY：ROAD	PRS	7	7	999	250	2:24	2.4	東星※紅空	シエラ	gloryroad	f	uma vs. モリモリあつし
26	I've heard it said	PST	3	3.5	510	165	2:06	1.0	Toaster	\N	hearditsaid	f	Combatplayer
27	I've heard it said	PRS	6	6	664	165	2:06	1.0	Toaster	\N	hearditsaid	f	Combatplayer
28	I've heard it said	FTR	8	8.1	864	165	2:06	1.0	Toaster	\N	hearditsaid	f	Combatplayer
455	GLORY：ROAD	FTR	10	10.5	1479	250	2:24	2.4	東星※紅空	シエラ	gloryroad	f	uma vs. モリモリあつし
456	Monochrome Princess	PST	4	4.5	621	160	2:17	2.4	N↕TRO	GreeN	monochromeprincess	f	polysha
457	Monochrome Princess	PRS	7+	7.8	756	160	2:17	2.4	N↕TRO	GreeN	monochromeprincess	f	polysha
458	Monochrome Princess	FTR	9+	9.7	974	160	2:17	2.4	N↕TRO	GreeN	monochromeprincess	f	polysha
459	Heavenly caress	PST	3	3.5	855	241	2:15	2.4	Toaster	fixro2n	heavenlycaress	f	Noah
460	Heavenly caress	PRS	7	7.5	909	241	2:15	2.4	Toaster	fixro2n	heavenlycaress	f	Noah
461	Heavenly caress	FTR	9+	9.8	1560	241	2:15	2.4	Toaster	fixro2n	heavenlycaress	f	Noah
462	Heavenly caress	BYD	10+	10.9	1717	241	2:15	6.13	絶･零･夜	fixro2n	heavenlycaress	t	Noah
463	Senkyou	PST	3	3	627	90	2:31	2.4	k//eternal	未早	senkyou	f	MYTK
464	Senkyou	PRS	5	5.5	722	90	2:31	2.4	k//eternal	未早	senkyou	f	MYTK
465	Senkyou	FTR	8+	8.7	964	90	2:31	2.4	k//eternal	未早	senkyou	f	MYTK
466	Filament	PST	4	4.5	582	170	2:22	2.4	Toaster	Hanamori Hiro	filament	f	Puru
467	Filament	PRS	7+	7.8	780	170	2:22	2.4	Toaster	Hanamori Hiro	filament	f	Puru
468	Filament	FTR	9+	9.7	991	170	2:22	2.4	Toaster	Hanamori Hiro	filament	f	Puru
469	Avant Raze	PST	3	3.5	580	200	2:13	2.4	Avant Toast	LAM	avantraze	f	Sampling Masters MEGA
470	Avant Raze	PRS	6	6.5	727	200	2:13	2.4	Avant Toast	LAM	avantraze	f	Sampling Masters MEGA
471	Avant Raze	FTR	9	9.6	1125	200	2:13	2.4	Avant Toast	LAM	avantraze	f	Sampling Masters MEGA
472	BATTLE NO.1	PST	3	3.5	476	200	2:12	2.4	Nitro	Hanamori Hiro	battlenoone	f	TANO*C Sound Team
473	BATTLE NO.1	PRS	6	6.5	677	200	2:12	2.4	Nitro	Hanamori Hiro	battlenoone	f	TANO*C Sound Team
474	BATTLE NO.1	FTR	9+	9.7	1042	200	2:12	2.4	Arcaea Team	Hanamori Hiro	battlenoone	f	TANO*C Sound Team
475	La'qryma of the Wasteland	PST	3	3.5	447	168	2:23	2.5	Toaster	和音ハカ	laqryma	f	DJ Noriken
476	La'qryma of the Wasteland	PRS	6	6.5	651	168	2:23	2.5	Toaster	和音ハカ	laqryma	f	DJ Noriken
477	La'qryma of the Wasteland	FTR	9	9.1	956	168	2:23	2.5	Toaster	和音ハカ	laqryma	f	DJ Noriken
478	La'qryma of the Wasteland	BYD	10	10	1161	168	2:23	3.6	Nitro 「The Forsaken」	和音ハカ	laqryma	t	DJ Noriken
479	Einherjar Joker	PST	4	4	582	222	2:18	2.5	Requiem TaroNuke	すずなし	einherjar	f	DJ Genki vs Gram
480	Einherjar Joker	PRS	7	7	767	222	2:18	2.5	Requiem TaroNuke	すずなし	einherjar	f	DJ Genki vs Gram
481	Einherjar Joker	FTR	9+	9.8	1159	222	2:18	2.5	Requiem TaroNuke	すずなし	einherjar	f	DJ Genki vs Gram
482	Einherjar Joker	BYD	10+	10.9	1857	222	2:18	5.3	~REQUIEM~ 夜浪	すずなし	einherjar	t	DJ Genki vs Gram
483	IZANA	PST	5	5	609	222	2:03	2.5	NITRO	Nagu	izana	f	t+pazolite vs P*Light
484	IZANA	PRS	8	8.3	836	222	2:03	2.5	NITRO	Nagu	izana	f	t+pazolite vs P*Light
485	IZANA	FTR	10	10.3	976	222	2:03	2.5	NITRO	Nagu	izana	f	t+pazolite vs P*Light
486	SAIKYO STRONGER	PST	5	5.5	654	205	2:22	2.5	最強FUMEN (夜浪 ft. 東星)	KEI	saikyostronger	f	REDALiCE vs USAO
487	SAIKYO STRONGER	PRS	9	9.4	1067	205	2:22	2.5	最強FUMEN (夜浪 ft. 東星)	KEI	saikyostronger	f	REDALiCE vs USAO
488	SAIKYO STRONGER	FTR	11	11	1384	205	2:22	2.5	最強FUMEN (夜浪 ft. 東星)	KEI	saikyostronger	f	REDALiCE vs USAO
489	world.execute(me);	PST	3	3.5	452	130	2:31	2.5	toaster.chart(this);	そゐち	worldexecuteme	f	Mili
490	world.execute(me);	PRS	5	5	582	130	2:31	2.5	toaster.chart(this);	そゐち	worldexecuteme	f	Mili
491	world.execute(me);	FTR	8	8	851	130	2:31	2.5	toaster.chart(this);	そゐち	worldexecuteme	f	Mili
492	BLRINK	PST	3	3.5	400	115	2:43	2.5	過去の縁	Sta	blrink	f	Sta
493	BLRINK	PRS	7+	7.8	683	115	2:43	2.5	現在の縁	Sta	blrink	f	Sta
494	BLRINK	FTR	9+	9.7	1015	115	2:43	2.5	未来の縁	Sta	blrink	f	Sta
495	Oblivia	PST	3	3.5	574	180	2:28	2.6	Toaster	クルエルGZ	oblivia	f	Saiph
496	Oblivia	PRS	5	5	517	180	2:28	2.6	Toaster	クルエルGZ	oblivia	f	Saiph
497	Oblivia	FTR	8	8.3	956	180	2:28	2.6	Toaster	クルエルGZ	oblivia	f	Saiph
498	Oblivia	BYD	9+	9.7	1021	180	2:28	5.3	Nitro 「The Forgotten」	クルエルGZ	oblivia	t	Saiph
499	amygdata	PST	4	4	504	154	2:38	2.6	Nitro	久賀フーナ	amygdata	f	nitro
500	amygdata	PRS	7	7.5	711	154	2:38	2.6	Nitro	久賀フーナ	amygdata	f	nitro
501	amygdata	FTR	9+	9.7	1199	154	2:38	2.6	Nitro	久賀フーナ	amygdata	f	nitro
502	corps-sans-organes	PST	4	4.5	438	105	2:36	2.6	夜浪「月食」	softmode	corpssansorganes	f	cybermiso
503	corps-sans-organes	PRS	7+	7.8	615	105	2:36	2.6	夜浪「月食」	softmode	corpssansorganes	f	cybermiso
504	corps-sans-organes	FTR	10	10.6	1077	105	2:36	2.6	夜浪「月食」	softmode	corpssansorganes	f	cybermiso
505	Equilibrium	PST	3	3.5	587	180	2:17	3.0	Kurorak	巻羊	equilibrium	f	Maozon
29	Babaroque	PST	3	3	402	136	2:28	1.0	Toaster	\N	babaroque	f	cYsmix
30	Babaroque	PRS	6	6.5	645	136	2:28	1.0	Toaster	\N	babaroque	f	cYsmix
31	Babaroque	FTR	8	8.5	808	136	2:28	1.0	Toaster	\N	babaroque	f	cYsmix
32	memoryfactory.lzh	PST	2	2.5	308	100	2:09	1.0	Nitro	Frums	memoryfactory	f	Frums
506	Equilibrium	PRS	6	6.5	724	180	2:17	3.0	Kurorak	巻羊	equilibrium	f	Maozon
507	Equilibrium	FTR	9	9.4	951	180	2:17	3.0	Kurorak	巻羊	equilibrium	f	Maozon
508	Antagonism	PST	4	4.5	431	160	2:19	3.0	Toaster	リウイチ	antagonism	f	Yooh vs. siromaru
509	Antagonism	PRS	7+	7.8	738	160	2:19	3.0	Toaster	リウイチ	antagonism	f	Yooh vs. siromaru
510	Antagonism	FTR	9+	9.9	1142	160	2:19	3.0	Toaster	リウイチ	antagonism	f	Yooh vs. siromaru
511	Lost Desire	PST	4	4	684	170	2:38	3.0	Darkest Dream	シエラ	lostdesire	f	Powerless feat. Sennzai
512	Lost Desire	PRS	7+	7.8	871	170	2:38	3.0	Darkest Dream	シエラ	lostdesire	f	Powerless feat. Sennzai
513	Lost Desire	FTR	9+	9.8	1154	170	2:38	3.0	Darkest Dream	シエラ	lostdesire	f	Powerless feat. Sennzai
514	Dantalion	PST	5	5	731	186	2:32	3.0	夜浪	Rolua	dantalion	f	Team Grimoire
515	Dantalion	PRS	8	8.2	843	186	2:32	3.0	東星	Rolua	dantalion	f	Team Grimoire
516	Dantalion	FTR	10+	10.8	1476	186	2:32	3.0	夜浪 X 東星 "The Lost"	Rolua	dantalion	f	Team Grimoire
517	#1f1e33	PST	5	5.5	765	181	2:43	3.0	夜浪	望月けい	ifi	f	かめりあ(EDP)
518	#1f1e33	PRS	9	9.2	1144	181	2:43	3.0	夜浪	望月けい	ifi	f	かめりあ(EDP)
519	#1f1e33	FTR	11	11.1	1576	181	2:43	3.0	夜浪 VS 東星 "Convergence"	望月けい	ifi	f	かめりあ(EDP)
520	Tempestissimo	PST	7	7	919	231	2:17	3.0	Prelude - Ouverture	シエラ	tempestissimo	f	t+pazolite
521	Tempestissimo	PRS	9	9.5	1034	231	2:17	3.0	Convergence - Intermezzo	シエラ	tempestissimo	f	t+pazolite
522	Tempestissimo	FTR	10+	10.7	1254	231	2:17	3.0	Onslaught - Crescendo	シエラ	tempestissimo	f	t+pazolite
523	Tempestissimo	BYD	11	11.7	1540	231	2:17	3.0	Finale - The Tempest	シエラ	tempestissimo	t	t+pazolite
524	Arcahv	PST	4	4.5	818	191	2:45	3.0	∅	シエラ	arcahv	f	Feryquitous
525	Arcahv	PRS	7+	7.8	884	191	2:45	3.0	∅	シエラ	arcahv	f	Feryquitous
526	Arcahv	FTR	9+	9.9	1065	191	2:45	3.0	∅	シエラ	arcahv	f	Feryquitous
527	Altale	PST	2	2.5	357	83-90	2:32	3.0	Kurorak	\N	altale	f	Sakuzyo
528	Altale	PRS	5	5.5	424	83-90	2:32	3.0	Kurorak	\N	altale	f	Sakuzyo
529	Altale	FTR	9+	9.8	690	83-90	2:32	3.0	Kurorak	\N	altale	f	Sakuzyo
530	Altale	BYD	10	10	1074	83-90	2:32	6.4	nora::neko << fantasy	\N	altale	f	Sakuzyo
531	Give Me a Nightmare	PST	3	3.5	676	95-190	2:36	3.0	CERiNG	mokeo	givemeanightmare	f	アリスシャッハと魔法の楽団
532	Give Me a Nightmare	PRS	5	5.5	817	95-190	2:36	3.0	CERiNG	mokeo	givemeanightmare	f	アリスシャッハと魔法の楽団
533	Give Me a Nightmare	FTR	8+	8.9	948	95-190	2:36	3.0	CERiNG	mokeo	givemeanightmare	f	アリスシャッハと魔法の楽団
534	Black Lotus	PST	3	3	653	200	1:55	3.0	Exschwasion	百舌谷	blacklotus	f	wa.
535	Black Lotus	PRS	6	6.5	687	200	1:55	3.0	Exschwasion	百舌谷	blacklotus	f	wa.
536	Black Lotus	FTR	9+	9.7	965	200	1:55	3.0	Exschwasion	百舌谷	blacklotus	f	wa.
537	Gekka (Short Version)	PST	4	4	559	132	2:44	3.0	Nitro	SoU	gekka	f	Nhato
538	Gekka (Short Version)	PRS	6	6.5	628	132	2:44	3.0	Nitro	SoU	gekka	f	Nhato
539	Gekka (Short Version)	FTR	8	8.6	817	132	2:44	3.0	Nitro	SoU	gekka	f	Nhato
540	Vivid Theory	PST	2	2	447	178	2:28	3.0	TaroNuke	Mechari	vividtheory	f	ak+q
541	Vivid Theory	PRS	5	5	658	178	2:28	3.0	TaroNuke	Mechari	vividtheory	f	ak+q
542	Vivid Theory	FTR	8+	8.8	885	178	2:28	3.0	TaroNuke	Mechari	vividtheory	f	ak+q
543	1F√	PST	2	2.5	411	130	2:20	3.0	Nitro	terry & nakanome	onefr	f	WHITEFISTS
544	1F√	PRS	6	6.5	539	130	2:20	3.0	Nitro	terry & nakanome	onefr	f	WHITEFISTS
545	1F√	FTR	8	8.2	758	130	2:20	3.0	Nitro	terry & nakanome	onefr	f	WHITEFISTS
546	Scarlet Cage	PST	4	4	570	166	2:37	3.0	赤Nitro	未早	scarletcage	f	Daisuke Kurosawa
547	Scarlet Cage	PRS	7	7.5	711	166	2:37	3.0	赤Nitro	未早	scarletcage	f	Daisuke Kurosawa
548	Scarlet Cage	FTR	9+	9.8	1195	166	2:37	3.0	赤Nitro	未早	scarletcage	f	Daisuke Kurosawa
549	Faint Light (Arcaea Edit)	PST	3	3	587	133	2:37	3.0	Nitro	SoU	faintlight	f	Taishi
550	Faint Light (Arcaea Edit)	PRS	6	6	711	133	2:37	3.0	Nitro	SoU	faintlight	f	Taishi
551	Faint Light (Arcaea Edit)	FTR	9	9.1	809	133	2:37	3.0	Nitro	SoU	faintlight	f	Taishi
552	Feels So Right feat. Renko	PST	3	3.5	594	180	2:14	3.0	Toaster	DJ Poyoshi	feelssoright	f	Mysteka
553	Feels So Right feat. Renko	PRS	6	6.5	636	180	2:14	3.0	Toaster	DJ Poyoshi	feelssoright	f	Mysteka
554	Feels So Right feat. Renko	FTR	9	9.3	947	180	2:14	3.0	Toaster	DJ Poyoshi	feelssoright	f	Mysteka
555	Teriqma	PST	3	3	345	128	2:26	3.0	Nitro	\N	teriqma	f	owl＊tree
556	Teriqma	PRS	6	6.5	579	128	2:26	3.0	Nitro	\N	teriqma	f	owl＊tree
557	Teriqma	FTR	9	9.4	873	128	2:26	3.0	Nitro	\N	teriqma	f	owl＊tree
33	memoryfactory.lzh	PRS	5	5.5	448	100	2:09	1.0	Nitro	Frums	memoryfactory	f	Frums
34	memoryfactory.lzh	FTR	8+	8.9	672	100	2:09	1.0	Nitro	Frums	memoryfactory	f	Frums
35	Snow White	PST	2	2.5	486	150	2:28	1.0	Toaster	\N	snowwhite	f	Puru
558	Teriqma	BYD	9+	9.7	954	128	2:26	4.4	én 200716	\N	teriqma	f	owl＊tree
559	MAHOROBA	PST	3	3	422	195	2:02	3.0	Nitro	そゐち	mahoroba	f	Zekk
560	MAHOROBA	PRS	6	6.5	632	195	2:02	3.0	Nitro	そゐち	mahoroba	f	Zekk
561	MAHOROBA	FTR	9	9.5	828	195	2:02	3.0	TaroNuke + Nitro	そゐち	mahoroba	f	Zekk
562	BADTEK	PST	4	4	532	190	1:57	3.1	Toaster	トロ３	badtek	f	EBIMAYO
563	BADTEK	PRS	7	7	595	190	1:57	3.1	Toaster	トロ３	badtek	f	EBIMAYO
564	BADTEK	FTR	9+	9.7	916	190	1:57	3.1	BADTOAST ft. Kurorak	トロ３	badtek	f	EBIMAYO
565	Malicious Mischance	PST	4	4	510	155	2:17	3.1	×NITRO×	nonokuro	maliciousmischance	f	s-don
566	Malicious Mischance	PRS	7+	7.8	706	155	2:17	3.1	×NITRO×	nonokuro	maliciousmischance	f	s-don
567	Malicious Mischance	FTR	10	10.2	1126	155	2:17	3.1	×NITRO×	nonokuro	maliciousmischance	f	s-don
568	Got hive of Ra	PST	3	3	322	268	2:06	3.2	Groove Nitro	\N	gothiveofra	f	E.G.G.
569	Got hive of Ra	PRS	6	6.5	509	268	2:06	3.2	Groove Nitro	\N	gothiveofra	f	E.G.G.
570	Got hive of Ra	FTR	9+	9.8	794	268	2:06	3.2	Groove Nitro	\N	gothiveofra	f	E.G.G.
571	BUCHiGiRE Berserker	PST	5	5	850	200	2:28	3.2	夜浪	\N	buchigireberserker	f	REDALiCE vs MASAKI
572	BUCHiGiRE Berserker	PRS	8	8.6	1046	200	2:28	3.2	夜浪	\N	buchigireberserker	f	REDALiCE vs MASAKI
573	BUCHiGiRE Berserker	FTR	10+	10.8	1412	200	2:28	3.2	東星 vs 夜浪 《BERSERK》	\N	buchigireberserker	f	REDALiCE vs MASAKI
574	Galaxy Friends	PST	3	3.5	474	300	2:09	3.2	Nitrome X	\N	galaxyfriends	f	Kobaryo
575	Galaxy Friends	PRS	6	6	572	300	2:09	3.2	Nitrome X	\N	galaxyfriends	f	Kobaryo
576	Galaxy Friends	FTR	9+	9.9	1013	300	2:09	3.2	Nitrome X	\N	galaxyfriends	f	Kobaryo
577	CROSS†OVER	PST	4	4	653	200	2:30	3.2	Exschwasion	Aremos	crossover	f	HyuN feat. LyuU
578	CROSS†OVER	PRS	6	6.5	810	200	2:30	3.2	Exschwasion	Aremos	crossover	f	HyuN feat. LyuU
579	CROSS†OVER	FTR	9	9.4	1094	200	2:30	3.2	Exschwasion	Aremos	crossover	f	HyuN feat. LyuU
580	Xeraphinite	PST	3	3	383	146	2:24	3.2	東星※空の宝石	シエラ	xeraphinite	f	BlackY
581	Xeraphinite	PRS	7	7.5	643	146	2:24	3.2	東星※空の宝石	シエラ	xeraphinite	f	BlackY
582	Xeraphinite	FTR	9+	9.8	1048	146	2:24	3.2	東星※空の宝石	シエラ	xeraphinite	f	BlackY
584	Lapis	PRS	6	6	520	146	2:18	3.2	CERiNG	Khronetic	lapis	f	SHIKI
585	Lapis	FTR	9	9.4	920	146	2:18	3.2	CERiNG	Khronetic	lapis	f	SHIKI
586	Xanatos	PST	4	4	735	170	2:38	3.2	XERiNG	クリス	xanatos	f	Tatsh
587	Xanatos	PRS	7	7.5	938	170	2:38	3.2	eXschwasion	クリス	xanatos	f	Tatsh
588	Xanatos	FTR	10	10	1232	170	2:38	3.2	XERiNG × eXschwasion × NitromeX	クリス	xanatos	f	Tatsh
589	Purple Verse	PST	4	4	558	170	2:25	3.3	Exschwasion	HakureiNeko	purpleverse	f	Hommarju
590	Purple Verse	PRS	7	7.5	664	170	2:25	3.3	Exschwasion	HakureiNeko	purpleverse	f	Hommarju
591	Purple Verse	FTR	9	9.6	1023	170	2:25	3.3	Exschwasion	HakureiNeko	purpleverse	f	Hommarju
592	Purple Verse	BYD	10	10.6	1202	170	2:25	5.3	/ERROR/ 絶滅	HakureiNeko	purpleverse	t	Hommarju
593	Alice à la mode	PST	2	2.5	436	80-134	2:30	3.3	Toaster	シエラ	alicealamode	f	Masanori Akita
594	Alice à la mode	PRS	6	6.5	618	80-134	2:30	3.3	Toaster	シエラ	alicealamode	f	Masanori Akita
595	Alice à la mode	FTR	9	9.2	872	80-134	2:30	3.3	Toaster	シエラ	alicealamode	f	Masanori Akita
596	Eccentric Tale	PST	2	2	313	132	2:17	3.3	Nitro	シエラ	eccentrictale	f	Yamajet
597	Eccentric Tale	PRS	5	5.5	483	132	2:17	3.3	Nitro	シエラ	eccentrictale	f	Yamajet
598	Eccentric Tale	FTR	8	8.4	732	132	2:17	3.3	Nitro	シエラ	eccentrictale	f	Yamajet
599	Eccentric Tale	BYD	9+	9.9	995	132	2:17	6.13	Nitro「The Aberrant」	シエラ + Khronetic	eccentrictale	t	Yamajet
600	Alice's Suitcase	PST	3	3.5	644	190	2:31	3.3	Kurorak	にんにくましまし	alicessuitcase	f	Endorfin.
601	Alice's Suitcase	PRS	6	6	660	190	2:31	3.3	Kurorak	にんにくましまし	alicessuitcase	f	Endorfin.
602	Alice's Suitcase	FTR	9	9.1	999	190	2:31	3.3	Kurorak	にんにくましまし	alicessuitcase	f	Endorfin.
603	Jump	PST	4	4	531	133	2:29	3.3	Nitroだー！	あるみっく	jump	f	Rasmus Faber
604	Jump	PRS	6	6	622	133	2:29	3.3	Nitroだー！	あるみっく	jump	f	Rasmus Faber
605	Jump	FTR	9	9	841	133	2:29	3.3	Nitroだー！	あるみっく	jump	f	Rasmus Faber
606	Felis	PST	4	4	463	155	2:18	3.3	東星	シエラ	felis	f	M2U
607	Felis	PRS	7	7.5	624	155	2:18	3.3	東星	シエラ	felis	f	M2U
608	Felis	FTR	10	10.4	1153	155	2:18	3.3	東星	シエラ	felis	f	M2U
609	Beside You	PST	2	2.5	526	181	1:50	3.3	CERiNG	にもし	besideyou	f	江口孝宏
610	Beside You	PRS	6	6	634	181	1:50	3.3	CERiNG	にもし	besideyou	f	江口孝宏
611	Beside You	FTR	8+	8.7	703	181	1:50	3.3	CERiNG	にもし	besideyou	f	江口孝宏
36	Snow White	PRS	5	5	672	150	2:28	1.0	Toaster	\N	snowwhite	f	Puru
37	Snow White	FTR	8	8.4	978	150	2:28	1.0	Toaster	\N	snowwhite	f	Puru
38	Snow White	BYD	9+	9.7	1031	150	2:28	6.4	én + Nitro	\N	snowwhite	f	Puru
612	Heart Jackin'	PST	3	3	506	160	2:37	3.3	TaroNuke + Nitro	mins	heartjackin	f	Yu_Asahina
613	Heart Jackin'	PRS	5	5.5	543	160	2:37	3.3	TaroNuke + Nitro	mins	heartjackin	f	Yu_Asahina
614	Heart Jackin'	FTR	9+	9.7	1112	160	2:37	3.3	TaroNuke + Nitro	mins	heartjackin	f	Yu_Asahina
615	To: Alice Liddell	PST	4	4	535	222	1:58	3.3	Yours Sincerely, 夜浪	みきさい + Khronetic	toaliceliddell	f	モリモリあつし
616	To: Alice Liddell	PRS	7	7.5	674	222	1:58	3.3	Yours Sincerely, 夜浪	みきさい + Khronetic	toaliceliddell	f	モリモリあつし
617	To: Alice Liddell	FTR	10	10.3	998	222	1:58	3.3	Yours Sincerely, 夜浪	みきさい + Khronetic	toaliceliddell	f	モリモリあつし
619	Lazy Addiction	PRS	6	6	647	185	2:23	3.4	Nitro without Toaster.	\N	lazyaddiction	f	sky_delta
620	Lazy Addiction	FTR	9	9.6	1031	185	2:23	3.4	Nitro without Toaster.	\N	lazyaddiction	f	sky_delta
621	Dazzle hop	PST	3	3.5	561	220	2:10	3.4	Kuro rak	\N	dazzlehop	f	Sampling Masters MEGA
622	Dazzle hop	PRS	6	6.5	571	220	2:10	3.4	Kuro rak	\N	dazzlehop	f	Sampling Masters MEGA
623	Dazzle hop	FTR	9+	9.7	1022	220	2:10	3.4	Kuro rak	\N	dazzlehop	f	Sampling Masters MEGA
624	Viyella's Tears	PST	4	4	716	218	2:37	3.4	東星の涙	\N	viyellastears	f	Laur
625	Viyella's Tears	PRS	7+	7.8	942	218	2:37	3.4	東星の涙	\N	viyellastears	f	Laur
626	Viyella's Tears	FTR	10	10.3	1403	218	2:37	3.4	東星の涙	\N	viyellastears	f	Laur
627	ω4	PST	3	3.5	816	71-192	2:45	3.4	τ0	\N	omegafour	f	穴山大輔 VS 光吉猛修 VS Kai
628	ω4	PRS	7+	7.8	943	71-192	2:45	3.4	τ0	\N	omegafour	f	穴山大輔 VS 光吉猛修 VS Kai
629	ω4	FTR	10+	10.8	1393	71-192	2:45	3.4	τ0	\N	omegafour	f	穴山大輔 VS 光吉猛修 VS Kai
631	April showers	PRS	5	5.5	544	79	2:09	3.4	Nitro-100号	\N	aprilshowers	f	cubesato
632	April showers	FTR	8	8.6	697	79	2:09	3.4	Nitro-100号	\N	aprilshowers	f	cubesato
633	7thSense	PST	3	3	360	150	2:09	3.4	石樂	\N	seventhsense	f	削除
634	7thSense	PRS	7+	7.8	739	150	2:09	3.4	石樂	\N	seventhsense	f	削除
635	7thSense	FTR	9+	9.9	925	150	2:09	3.4	石樂	\N	seventhsense	f	削除
636	Oshama Scramble!	PST	3	3.5	508	190	2:01	3.4	Nitro!+9牛乳	\N	oshamascramble	f	t+pazolite
637	Oshama Scramble!	PRS	6	6.5	568	190	2:01	3.4	Nitro!+99牛乳	\N	oshamascramble	f	t+pazolite
638	Oshama Scramble!	FTR	10	10	1073	190	2:01	3.4	Nitro!+999牛乳	\N	oshamascramble	f	t+pazolite
639	AMAZING MIGHTYYYY!!!!	PST	4	4.5	624	185	2:18	3.4	AMAZING TOASTYYYY!!!!	\N	amazingmightyyyy	f	WAiKURO
640	AMAZING MIGHTYYYY!!!!	PRS	7+	7.8	776	185	2:18	3.4	AMAZING TOASTYYYY!!!!	\N	amazingmightyyyy	f	WAiKURO
641	AMAZING MIGHTYYYY!!!!	FTR	10+	10.7	1249	185	2:18	3.4	AMAZING TOASTYYYY!!!!	\N	amazingmightyyyy	f	WAiKURO
642	Climax	PST	4	4.5	773	190	2:34	3.5	Nitro -EXTRA ROUND-	\N	climax	f	USAO
643	Climax	PRS	7+	7.8	988	190	2:34	3.5	Nitro -EXTRA ROUND-	\N	climax	f	USAO
644	Climax	FTR	10	10.4	1367	190	2:34	3.5	Nitro -EXTRA ROUND-	\N	climax	f	USAO
645	Last Celebration	PST	3	3.5	969	238	2:35	3.5	Nitro affected by 'CHUNITHM'	\N	lastcelebration	f	Laur vs CK
646	Last Celebration	PRS	6	6.5	994	238	2:35	3.5	Nitro affected by 'CHUNITHM'	\N	lastcelebration	f	Laur vs CK
647	Last Celebration	FTR	10	10.4	1475	238	2:35	3.5	Nitro affected by 'CHUNITHM'	\N	lastcelebration	f	Laur vs CK
648	Misdeed -la bonté de Dieu et l'origine du mal-	PST	5	5.5	814	190	2:44	3.5	神の啓示「人類の限界」	\N	gou	f	光吉猛修 VS 穴山大輔
649	Misdeed -la bonté de Dieu et l'origine du mal-	PRS	8	8.5	1070	190	2:44	3.5	神の啓示「人類の希望」	\N	gou	f	光吉猛修 VS 穴山大輔
650	Misdeed -la bonté de Dieu et l'origine du mal-	FTR	10+	10.9	1522	190	2:44	3.5	神の啓示「人類の未来」	\N	gou	f	光吉猛修 VS 穴山大輔
651	Glow	PST	4	4	504	165	2:18	3.5	Exschwasion	Taiyo Yamamoto	glow	f	SPACELECTRO
652	Glow	PRS	7	7.5	666	165	2:18	3.5	Exschwasion	Taiyo Yamamoto	glow	f	SPACELECTRO
653	Glow	FTR	9	9.3	916	165	2:18	3.5	Exschwasion	Taiyo Yamamoto	glow	f	SPACELECTRO
654	AttraqtiA	PST	4	4	732	202	2:38	3.5	Toaster affected by 'CHUNITHM'	Enji	attraqtia	f	かめりあ
655	AttraqtiA	PRS	8	8.3	1002	202	2:38	3.5	Toaster affected by 'CHUNITHM'	Enji	attraqtia	f	かめりあ
656	AttraqtiA	FTR	10	10.6	1433	202	2:38	3.5	Toaster affected by 'CHUNITHM'	Enji	attraqtia	f	かめりあ
657	enchanted love	PST	2	2	436	95	2:12	3.5	Toaster	百舌谷	enchantedlove	f	linear ring
658	enchanted love	PRS	4	4.5	617	95	2:12	3.5	Toaster	百舌谷	enchantedlove	f	linear ring
659	enchanted love	FTR	8	8.6	759	95	2:12	3.5	Toaster	百舌谷	enchantedlove	f	linear ring
660	Bamboo	PST	3	3	499	5-315	2:20	3.5	竹の子	石王マサト	take	f	立秋 feat.ちょこ
661	Bamboo	PRS	6	6.5	631	5-315	2:20	3.5	竹の子	石王マサト	take	f	立秋 feat.ちょこ
662	Bamboo	FTR	10	10	1050	5-315	2:20	3.5	竹の子	石王マサト	take	f	立秋 feat.ちょこ
663	GIMME DA BLOOD	PST	3	3.5	582	87-110	2:13	3.5	夜浪	すずなし	gimmedablood	f	C-Show
39	Relentless	PST	4	4.5	607	174	2:17	1.0	Nitro	SERXPHIS	relentless	f	Akira Complex
40	Relentless	PRS	6	6.5	722	174	2:17	1.0	Nitro	SERXPHIS	relentless	f	Akira Complex
583	Lapis	PST	2	2	391	146	2:18	3.2	CERiNG	Khronetic	lapis	f	SHIKI
664	GIMME DA BLOOD	PRS	7	7.5	737	87-110	2:13	3.5	夜浪	すずなし	gimmedablood	f	C-Show
665	GIMME DA BLOOD	FTR	10	10.5	1093	87-110	2:13	3.5	夜浪	すずなし	gimmedablood	f	C-Show
666	Can I Friend You on Bassbook? Lol	PST	3	3	415	128	2:26	3.5	トースト食べる？笑	\N	bassline	f	かめりあ feat. ななひら
667	Can I Friend You on Bassbook? Lol	PRS	6	6.5	548	128	2:26	3.5	トースト食べる？笑	\N	bassline	f	かめりあ feat. ななひら
668	Can I Friend You on Bassbook? Lol	FTR	9	9.3	861	128	2:26	3.5	トースト食べる？笑	\N	bassline	f	かめりあ feat. ななひら
669	Life is PIANO	PST	3	3.5	398	133	2:10	3.5	Nitro	\N	lifeispiano	f	Junk
670	Life is PIANO	PRS	6	6	437	133	2:10	3.5	Nitro	\N	lifeispiano	f	Junk
671	Life is PIANO	FTR	9	9.1	674	133	2:10	3.5	Nitro	\N	lifeispiano	f	Junk
672	Paper Witch	PST	2	2	348	130	2:29	3.6	CERiNG	桶乃かもく	paperwitch	f	Yu-dachi
673	Paper Witch	PRS	5	5	487	130	2:29	3.6	CERiNG	桶乃かもく	paperwitch	f	Yu-dachi
674	Paper Witch	FTR	8+	8.7	793	130	2:29	3.6	CERiNG	桶乃かもく	paperwitch	f	Yu-dachi
675	Crystal Gravity	PST	3	3.5	571	178	2:04	3.6	Exschwasion	雨傘ゆん	crystalgravity	f	Tanchiky vs. siromaru
676	Crystal Gravity	PRS	6	6.5	653	178	2:04	3.6	Exschwasion	雨傘ゆん	crystalgravity	f	Tanchiky vs. siromaru
677	Crystal Gravity	FTR	9	9.4	872	178	2:04	3.6	Exschwasion	雨傘ゆん	crystalgravity	f	Tanchiky vs. siromaru
678	Far Away Light	PST	4	4.5	656	180-216	2:29	3.6	Toaster	梅まろ	farawaylight	f	technoplanet feat. はるの & 黒沢ダイスケ
679	Far Away Light	PRS	7+	7.8	769	180-216	2:29	3.6	Toaster	梅まろ	farawaylight	f	technoplanet feat. はるの & 黒沢ダイスケ
680	Far Away Light	FTR	9+	9.8	1322	180-216	2:29	3.6	Toaster	梅まろ	farawaylight	f	technoplanet feat. はるの & 黒沢ダイスケ
681	Löschen	PST	3	3.5	642	181	2:20	3.6	絶滅	LOWRISE	loschen	f	BlackY feat. Risa Yuzuki
682	Löschen	PRS	7	7	850	181	2:20	3.6	絶滅	LOWRISE	loschen	f	BlackY feat. Risa Yuzuki
683	Löschen	FTR	10	10.2	1235	181	2:20	3.6	絶滅	LOWRISE	loschen	f	BlackY feat. Risa Yuzuki
684	Aegleseeker	PST	5	5.5	973	234	2:27	3.6	⟨RECORD START⟩ 0:	シエラ	aegleseeker	f	Silentroom vs Frums
685	Aegleseeker	PRS	9	9.1	1235	234	2:27	3.6	⟨OBSRV⟩ boundary(?°a,?°A)	シエラ	aegleseeker	f	Silentroom vs Frums
686	Aegleseeker	FTR	11	11.2	1568	234	2:27	3.6	L₆ː The Void	シエラ	aegleseeker	f	Silentroom vs Frums
687	Coastal Highway	PST	3	3	355	110	2:29	3.6	Exschwasion	水視ずみ	coastalhighway	f	Glitch Droids
688	Coastal Highway	PRS	6	6	479	110	2:29	3.6	Exschwasion	水視ずみ	coastalhighway	f	Glitch Droids
689	Coastal Highway	FTR	9	9.1	732	110	2:29	3.6	Exschwasion	水視ずみ	coastalhighway	f	Glitch Droids
690	ΟΔΥΣΣΕΙΑ	PST	4	4	717	174	2:24	3.6	ΤΟΑΣΤΕΡ	SHIROTA.	odysseia	f	Sober Bear
691	ΟΔΥΣΣΕΙΑ	PRS	7+	7.8	909	174	2:24	3.6	ΤΟΑΣΤΕΡ	SHIROTA.	odysseia	f	Sober Bear
692	ΟΔΥΣΣΕΙΑ	FTR	9	9.5	1092	174	2:24	3.6	ΤΟΑΣΤΕΡ	SHIROTA.	odysseia	f	Sober Bear
693	Overwhelm	PST	5	5	854	200	2:29	3.6	夜浪	緋原ヨウ	overwhelm	f	xi
694	Overwhelm	PRS	8	8.5	1038	200	2:29	3.6	夜浪	緋原ヨウ	overwhelm	f	xi
695	Overwhelm	FTR	10	10.6	1251	200	2:29	3.6	夜浪	緋原ヨウ	overwhelm	f	xi
696	Vandalism	PST	3	3.5	668	194	2:30	3.6	Kurorak	Asagon.	vandalism	f	Ashrount
697	Vandalism	PRS	7	7	685	194	2:30	3.6	Kurorak	Asagon.	vandalism	f	Ashrount
698	Vandalism	FTR	9+	9.7	1087	194	2:30	3.6	Kurorak	Asagon.	vandalism	f	Ashrount
699	Turbocharger	PST	2	2.5	419	128-170	2:29	3.6	Toaster	志月	turbocharger	f	A/I
700	Turbocharger	PRS	6	6	659	128-170	2:29	3.6	Toaster	志月	turbocharger	f	A/I
701	Turbocharger	FTR	9	9	979	128-170	2:29	3.6	Toaster	志月	turbocharger	f	A/I
702	THE ULTIMACY	PST	3	3	749	200	2:28	3.6	東星 vs Toaster	fixro2n	theultimacy	f	aran vs Massive New Krew
703	THE ULTIMACY	PRS	7	7	919	200	2:28	3.6	東星 vs Toaster	fixro2n	theultimacy	f	aran vs Massive New Krew
704	THE ULTIMACY	FTR	9+	9.8	1304	200	2:28	3.6	東星 vs Toaster	fixro2n	theultimacy	f	aran vs Massive New Krew
705	REKKA RESONANCE	PST	5	5	860	240	2:22	3.6	夜浪 vs Nitro	Nagu + yusi.	rekkaresonance	f	REDALiCE vs Kobaryo
706	REKKA RESONANCE	PRS	8+	8.9	1051	240	2:22	3.6	夜浪 vs Nitro	Nagu + yusi.	rekkaresonance	f	REDALiCE vs Kobaryo
707	REKKA RESONANCE	FTR	10+	10.7	1212	240	2:22	3.6	夜浪 vs Nitro	Nagu + yusi.	rekkaresonance	f	REDALiCE vs Kobaryo
708	False Embellishment	PST	3	3.5	576	155	2:29	3.7	Exschwasion	あすだ	kyogenkigo	f	影虎。 & ikaruga_nex
709	False Embellishment	PRS	6	6.5	684	155	2:29	3.7	Exschwasion	あすだ	kyogenkigo	f	影虎。 & ikaruga_nex
710	False Embellishment	FTR	9	9.3	969	155	2:29	3.7	Exschwasion	あすだ	kyogenkigo	f	影虎。 & ikaruga_nex
711	False Embellishment	BYD	9+	9.9	1325	155	2:29	6.13	¬ə	あすだ	kyogenkigo	t	影虎。 & ikaruga_nex
712	HIVEMIND	PST	4	4	995	252	2:13	3.7	NITRO -unconnected-	fixro2n	hivemind	f	かたぎり
41	Relentless	FTR	8	8	1015	174	2:17	1.0	Nitro	SERXPHIS	relentless	f	Akira Complex
42	Shades of Light in a Transcendent Realm	PST	3	3	517	170	2:30	1.0	Nitro	RiceGnat	shadesoflight	f	ak+q
618	Lazy Addiction	PST	2	2.5	462	185	2:23	3.4	Nitro without Toaster.	\N	lazyaddiction	f	sky_delta
713	HIVEMIND	PRS	8	8.6	988	252	2:13	3.7	NITRO -unconnected-	fixro2n	hivemind	f	かたぎり
714	HIVEMIND	FTR	10	10	1252	252	2:13	3.7	NITRO -unconnected-	fixro2n	hivemind	f	かたぎり
715	Seclusion	PST	4	4	544	175	2:18	3.7	Exschwasion	海鵜げそ	seclusion	f	Laur feat. Sennzai
716	Seclusion	PRS	7	7.5	762	175	2:18	3.7	Exschwasion	海鵜げそ	seclusion	f	Laur feat. Sennzai
717	Seclusion	FTR	10	10.6	1132	175	2:18	3.7	N•Ex•T	海鵜げそ	seclusion	f	Laur feat. Sennzai
718	Small Cloud Sugar Candy	PST	3	3	548	220	2:13	3.7	én	のう	smallcloud	f	テヅカ x Aoi feat.桃雛なの
719	Small Cloud Sugar Candy	PRS	6	6.5	727	220	2:13	3.7	én	のう	smallcloud	f	テヅカ x Aoi feat.桃雛なの
720	Small Cloud Sugar Candy	FTR	9	9.3	919	220	2:13	3.7	én	のう	smallcloud	f	テヅカ x Aoi feat.桃雛なの
721	Small Cloud Sugar Candy	BYD	10	10.3	1158	220	2:13	6.13	@#7¥M!$	のう + jht	smallcloud	t	テヅカ x Aoi feat.桃雛なの
722	AlterAle	PST	3	3	728	220-245	2:27	3.7	CERiNG	ちょこ庵	alterale	f	Arik Kau Delay (アラ＆かゆき＆でり）
723	AlterAle	PRS	6	6	881	220-245	2:27	3.7	CERiNG	ちょこ庵	alterale	f	Arik Kau Delay (アラ＆かゆき＆でり）
724	AlterAle	FTR	9+	9.7	1277	220-245	2:27	3.7	CERiNG	ちょこ庵	alterale	f	Arik Kau Delay (アラ＆かゆき＆でり）
725	Divine Light of Myriad	PST	4	4.5	798	172	2:22	3.7	東星※神授	緋原ヨウ	divinelight	f	yoho
726	Divine Light of Myriad	PRS	7+	7.8	835	172	2:22	3.7	東星※神授	緋原ヨウ	divinelight	f	yoho
727	Divine Light of Myriad	FTR	10+	10.8	1021	172	2:22	3.7	東星※神授	緋原ヨウ	divinelight	f	yoho
728	Mazy Metroplex	PST	3	3	453	155	2:09	3.8	Exschwasion	\N	mazymetroplex	f	aran
729	Mazy Metroplex	PRS	7+	7.8	704	155	2:09	3.8	Exschwasion	\N	mazymetroplex	f	aran
730	Mazy Metroplex	FTR	9+	9.8	952	155	2:09	3.8	Exschwasion	\N	mazymetroplex	f	aran
731	Quon	PST	2	2.5	425	170	2:04	3.8	CERiNG	\N	quonwacca	f	DJ Noriken
732	Quon	PRS	6	6	496	170	2:04	3.8	CERiNG	\N	quonwacca	f	DJ Noriken
733	Quon	FTR	8+	8.7	749	170	2:04	3.8	CERiNG	\N	quonwacca	f	DJ Noriken
734	Quon	BYD	10	10.2	1044	170	2:04	3.8	XIII: The Journey/Nitro	\N	quonwacca	f	DJ Noriken
735	with U	PST	2	2.5	448	155	2:20	3.8	én	\N	withu	f	t+pazolite & Massive New Krew feat. リリィ(CV:青木志貴)
736	with U	PRS	6	6.5	649	155	2:20	3.8	én	\N	withu	f	t+pazolite & Massive New Krew feat. リリィ(CV:青木志貴)
737	with U	FTR	9	9.4	932	155	2:20	3.8	én	\N	withu	f	t+pazolite & Massive New Krew feat. リリィ(CV:青木志貴)
738	GENOCIDER	PST	4	4.5	832	250-390	2:19	3.8	Toaster	Taiyo Yamamoto	genocider	f	DJ Myosuke
739	GENOCIDER	PRS	8+	8.9	1025	250-390	2:19	3.8	Toaster	Taiyo Yamamoto	genocider	f	DJ Myosuke
740	GENOCIDER	FTR	10+	10.8	1483	250-390	2:19	3.8	Toaster	Taiyo Yamamoto	genocider	f	DJ Myosuke
741	Let you DIVE! (nitro rmx)	PST	3	3	608	185	2:27	3.8	Nitro	\N	letyoudivermx	f	nitro (lowiro)
742	Let you DIVE! (nitro rmx)	PRS	6	6.5	819	185	2:27	3.8	Nitro	\N	letyoudivermx	f	nitro (lowiro)
743	Let you DIVE! (nitro rmx)	FTR	9	9.4	1049	185	2:27	3.8	Nitro	\N	letyoudivermx	f	nitro (lowiro)
744	Sheriruth (Laur Remix)	PST	4	4	671	200	2:04	3.8	Nitro	\N	sheriruthrmx	f	Laur
745	Sheriruth (Laur Remix)	PRS	7+	7.8	795	200	2:04	3.8	Nitro	\N	sheriruthrmx	f	Laur
746	Sheriruth (Laur Remix)	FTR	10	10.5	1134	200	2:04	3.8	東星※恣意	\N	sheriruthrmx	f	Laur
747	Evening in Scarlet	PST	4	4	530	170	2:08	3.8	Nitroだー！	シエラ + yusi.	eveninginscarlet	f	Freezer feat.妃苺
748	Evening in Scarlet	PRS	7	7	638	170	2:08	3.8	Nitroだー！	シエラ + yusi.	eveninginscarlet	f	Freezer feat.妃苺
749	Evening in Scarlet	FTR	9	9.5	922	170	2:08	3.8	Nitroだー！	シエラ + yusi.	eveninginscarlet	f	Freezer feat.妃苺
750	blue comet	PST	3	3.5	494	100-172	2:24	3.8	Toaster	Bison	bluecomet	f	ああああ
751	blue comet	PRS	5	5	645	100-172	2:24	3.8	Toaster	Bison	bluecomet	f	ああああ
752	blue comet	FTR	8	8.2	776	100-172	2:24	3.8	Toaster	Bison	bluecomet	f	ああああ
753	ENERGY SYNERGY MATRIX	PST	3	3.5	471	160	2:03	3.8	POWER NITRO	からめる	energysynergymatrix	f	Tanchiky
754	ENERGY SYNERGY MATRIX	PRS	7	7	608	160	2:03	3.8	POWER NITRO	からめる	energysynergymatrix	f	Tanchiky
755	ENERGY SYNERGY MATRIX	FTR	9	9.6	922	160	2:03	3.8	POWER NITRO	からめる	energysynergymatrix	f	Tanchiky
756	ENERGY SYNERGY MATRIX	BYD	10	10.3	1011	160	2:03	6.4	白亜紀と古第三紀の間の大量絶滅	からめる	energysynergymatrix	f	Tanchiky
757	G e n g a o z o	PST	4	4	580	153	2:40	3.8	_ P A S T	\N	gengaozo	f	-45
758	G e n g a o z o	PRS	8	8.1	870	153	2:40	3.8	_ P R E S E N T	\N	gengaozo	f	-45
759	G e n g a o z o	FTR	10	10.1	1353	153	2:40	3.8	_ F U T U R E	\N	gengaozo	f	-45
760	goldenslaughterer	PST	4	4	864	133	3:04	3.8	Exschwasion	\N	goldenslaughterer	f	zts
761	goldenslaughterer	PRS	6	6.5	880	133	3:04	3.8	Exschwasion	\N	goldenslaughterer	f	zts
43	Shades of Light in a Transcendent Realm	PRS	6	6	789	170	2:30	1.0	Nitro	RiceGnat	shadesoflight	f	ak+q
44	Shades of Light in a Transcendent Realm	FTR	8	8.3	1067	170	2:30	1.0	Nitro	RiceGnat	shadesoflight	f	ak+q
45	Shades of Light in a Transcendent Realm	BYD	9	9.1	1042	170	2:30	4.3	N↑TRO	RiceGnat	shadesoflight	t	ak+q
762	goldenslaughterer	FTR	9+	9.7	1326	133	3:04	3.8	Exschwasion	\N	goldenslaughterer	f	zts
763	lastendconductor	PST	3	3.5	726	139	3:04	3.8	Nitro	\N	lastendconductor	f	zts
764	lastendconductor	PRS	7	7.5	901	139	3:04	3.8	Nitro	\N	lastendconductor	f	zts
765	lastendconductor	FTR	9	9.4	1209	139	3:04	3.8	Nitro	\N	lastendconductor	f	zts
766	lastendconductor	BYD	10	10.2	1339	139	3:04	3.8	Toaster	\N	lastendconductor	f	zts
767	Redolent Shape	PST	4	4.5	570	150	2:12	3.8	絶滅	ＫＴ。	redolentshape	f	Sanaas
768	Redolent Shape	PRS	7	7.5	717	150	2:12	3.8	絶滅	ＫＴ。	redolentshape	f	Sanaas
769	Redolent Shape	FTR	10	10.2	1088	150	2:12	3.8	絶滅	ＫＴ。	redolentshape	f	Sanaas
770	Cosmica	PST	2	2.5	428	110	2:25	3.9	Nitro	シエラ	cosmica	f	Nhato
771	Cosmica	PRS	5	5	566	110	2:25	3.9	Nitro	シエラ	cosmica	f	Nhato
772	Cosmica	FTR	8+	8.8	773	110	2:25	3.9	Nitro missing Toaster.	シエラ	cosmica	f	Nhato
773	Ascent	PST	3	3	455	145	2:24	3.9	CER↑NG	小奈きなこ	ascent	f	TANUKI
774	Ascent	PRS	6	6	626	145	2:24	3.9	CER↑NG	小奈きなこ	ascent	f	TANUKI
775	Ascent	FTR	9+	9.8	1023	145	2:24	3.9	Exschwas↑on with CER↑NG	小奈きなこ	ascent	f	TANUKI
776	Live Fast Die Young	PST	4	4.5	565	153	2:16	3.9	Nitro	シエラ	livefastdieyoung	f	anubasu-anubasu
777	Live Fast Die Young	PRS	8	8.5	837	153	2:16	3.9	Nitro	シエラ	livefastdieyoung	f	anubasu-anubasu
778	Live Fast Die Young	FTR	10	10.6	1292	153	2:16	3.9	Nitro with Toaster.	シエラ	livefastdieyoung	f	anubasu-anubasu
779	Summer Fireworks of Love	PST	3	3	478	160	2:30	3.9	夏のNitro	シエラ	summerfireworks	f	karatoPαnchii feat.はるの
780	Summer Fireworks of Love	PRS	6	6.5	641	160	2:30	3.9	夏のNitro	シエラ	summerfireworks	f	karatoPαnchii feat.はるの
781	Summer Fireworks of Love	FTR	9+	9.9	1088	160	2:30	3.9	夏のNitro	シエラ	summerfireworks	f	karatoPαnchii feat.はるの
782	First Snow	PST	2	2.5	366	88	2:40	3.10	Nitro	ヒトこもる	firstsnow	f	黒魔
783	First Snow	PRS	4	4.5	442	88	2:40	3.10	Nitro	ヒトこもる	firstsnow	f	黒魔
784	First Snow	FTR	7+	7.8	578	88	2:40	3.10	Nitro	ヒトこもる	firstsnow	f	黒魔
785	Blue Rose	PST	2	2	595	250-295	2:36	3.10	CERiNG	チェリム	bluerose	f	Cosmograph
786	Blue Rose	PRS	6	6	669	250-295	2:36	3.10	CERiNG	チェリム	bluerose	f	Cosmograph
787	Blue Rose	FTR	9	9.1	955	250-295	2:36	3.10	CERiNG	チェリム	bluerose	f	Cosmograph
788	Blocked Library	PST	3	3.5	449	148	2:14	3.10	Exschwasion	めとこ	blockedlibrary	f	影虎。
789	Blocked Library	PRS	6	6.5	622	148	2:14	3.10	Exschwasion	めとこ	blockedlibrary	f	影虎。
790	Blocked Library	FTR	9	9.3	850	148	2:14	3.10	Exschwasion	めとこ	blockedlibrary	f	影虎。
791	nέο κόsmo	PST	4	4	603	190	2:13	3.10	Nitro × Toaster	久坂んむり	neokosmo	f	ak+q × Street
792	nέο κόsmo	PRS	7+	7.8	791	190	2:13	3.10	Nitro × Toaster	久坂んむり	neokosmo	f	ak+q × Street
793	nέο κόsmo	FTR	9+	9.7	979	190	2:13	3.10	Nitro × Toaster	久坂んむり	neokosmo	f	ak+q × Street
794	Lightning Screw	PST	4	4.5	611	190	2:07	3.10	東星	シエラ	lightningscrew	f	HiTECH NINJA
795	Lightning Screw	PRS	7+	7.8	811	190	2:07	3.10	東星	シエラ	lightningscrew	f	HiTECH NINJA
796	Lightning Screw	FTR	10	10.5	1192	190	2:07	3.10	東星	シエラ	lightningscrew	f	HiTECH NINJA
797	Lights of Muse	PST	2	2.5	333	180	1:40	3.11	antymis	\N	lightsofmuse	f	Ayatsugu_Otowa
798	Lights of Muse	PRS	6	6	438	180	1:40	3.11	antymis	\N	lightsofmuse	f	Ayatsugu_Otowa
799	Lights of Muse	FTR	8+	8.9	580	180	1:40	3.11	antymis	\N	lightsofmuse	f	Ayatsugu_Otowa
800	Final Step!	PST	3	3.5	625	180	2:17	3.11	CERiNG	\N	finalstep	f	Lime
801	Final Step!	PRS	6	6.5	684	180	2:17	3.11	CERiNG	\N	finalstep	f	Lime
802	Final Step!	FTR	9	9.4	1056	180	2:17	3.11	CERiNG	\N	finalstep	f	Lime
803	Haze of Autumn	PST	3	3.5	533	180	2:32	3.11	秋のén	MiyU	akinokagerou	f	karatoPαnchii feat.はるの
804	Haze of Autumn	PRS	7	7	733	180	2:32	3.11	秋のén	MiyU	akinokagerou	f	karatoPαnchii feat.はるの
805	Haze of Autumn	FTR	9+	9.8	1077	180	2:32	3.11	秋のén	MiyU	akinokagerou	f	karatoPαnchii feat.はるの
806	Medusa	PST	4	4.5	550	165	2:04	3.11	Toaster	\N	medusa	f	HiTECH NINJA
807	Medusa	PRS	7	7	645	165	2:04	3.11	Toaster	\N	medusa	f	HiTECH NINJA
808	Medusa	FTR	10	10.1	931	165	2:04	3.11	Toaster	\N	medusa	f	HiTECH NINJA
809	init()	PST	4	4	713	180	2:24	3.11	Toaster	そゐち	init	f	kamome sano
810	init()	PRS	7	7.5	957	180	2:24	3.11	Toaster	そゐち	init	f	kamome sano
811	init()	FTR	9+	9.8	1204	180	2:24	3.11	Toaster	そゐち	init	f	kamome sano
46	Vexaria	PST	2	2.5	369	180	2:12	1.0	Nitro	Koyama Mai	vexaria	f	ak+q
47	Vexaria	PRS	5	5	534	180	2:12	1.0	Nitro	Koyama Mai	vexaria	f	ak+q
48	Vexaria	FTR	7	7	734	180	2:12	1.0	Nitro	Koyama Mai	vexaria	f	ak+q
812	INTERNET OVERDOSE	PST	3	3	430	163	2:02	3.12	Nitro Ch.	kinakobooster	internetoverdose	f	Aiobahn feat. KOTOKO
813	INTERNET OVERDOSE	PRS	6	6.5	578	163	2:02	3.12	Nitro Ch.	kinakobooster	internetoverdose	f	Aiobahn feat. KOTOKO
814	INTERNET OVERDOSE	FTR	8	8.4	657	163	2:02	3.12	Nitro Ch.	kinakobooster	internetoverdose	f	Aiobahn feat. KOTOKO
815	Sakura Fubuki	PST	3	3.5	526	175	1:59	3.12	én	\N	sakurafubuki	f	Street
816	Sakura Fubuki	PRS	6	6.5	571	175	1:59	3.12	én	\N	sakurafubuki	f	Street
817	Sakura Fubuki	FTR	9	9.4	837	175	1:59	3.12	én	\N	sakurafubuki	f	Street
818	NULCTRL	PST	3	3	407	100	2:32	3.12	moonquay [CON]	\N	nulctrl	f	Silentroom
819	NULCTRL	PRS	7	7.5	410	100	2:32	3.12	moonquay [AUX]	\N	nulctrl	f	Silentroom
820	NULCTRL	FTR	9	9.5	715	100	2:32	3.12	moonquay [NUL]	\N	nulctrl	f	Silentroom
821	Macrocosmic Modulation	PST	4	4	608	170	2:32	3.12	Exschwas↕on	装甲枕	macromod	f	JAKAZiD
822	Macrocosmic Modulation	PRS	7+	7.8	794	170	2:32	3.12	Exschwas↕on	装甲枕	macromod	f	JAKAZiD
823	Macrocosmic Modulation	FTR	9+	9.8	1117	170	2:32	3.12	Exschwas↕on	装甲枕	macromod	f	JAKAZiD
824	NEO WINGS	PST	4	4	591	168	2:32	3.12	Toaster	シエラ	neowings	f	SOUND HOLIC feat. Nana Takahashi
825	NEO WINGS	PRS	7	7.5	840	168	2:32	3.12	Toaster	シエラ	neowings	f	SOUND HOLIC feat. Nana Takahashi
826	NEO WINGS	FTR	10	10.2	1328	168	2:32	3.12	Toaster	シエラ	neowings	f	SOUND HOLIC feat. Nana Takahashi
827	Kissing Lucifer	PST	4	4.5	639	170	2:26	3.12	NITRO	Siino	kissinglucifer	f	ETIA.
828	Kissing Lucifer	PRS	7+	7.8	770	170	2:26	3.12	NITRO	Siino	kissinglucifer	f	ETIA.
829	Kissing Lucifer	FTR	10	10.4	1183	170	2:26	3.12	NITRO	Siino	kissinglucifer	f	ETIA.
830	Ävril -Flicka i krans-	PST	3	3	459	130	2:45	3.12	Aster -Får i Vaaris-	しいたけ	avril	t	Rigël Theatre
831	Ävril -Flicka i krans-	PRS	6	6	607	130	2:45	3.12	Aster -Får i Vaaris-	しいたけ	avril	t	Rigël Theatre
832	Ävril -Flicka i krans-	FTR	8	8.3	851	130	2:45	3.12	Aster -Får i Vaaris-	しいたけ	avril	f	Rigël Theatre
833	Aurgelmir	PST	4	4.5	540	122-230	2:17	3.12	夜浪	\N	aurgelmir	f	溝口ゆうま feat. 大瀬良あい
834	Aurgelmir	PRS	8	8.5	765	122-230	2:17	3.12	夜浪	\N	aurgelmir	f	溝口ゆうま feat. 大瀬良あい
835	Aurgelmir	FTR	10	10.5	1100	122-230	2:17	3.12	夜浪	\N	aurgelmir	f	溝口ゆうま feat. 大瀬良あい
836	Head BONK ache	PST	4	4	570	132-165	2:25	3.12	Nitro	空読無 白眼	headbonkache	f	saaa ft. MC iwata Bros.
837	Head BONK ache	PRS	7	7	725	132-165	2:25	3.12	Nitro	空読無 白眼	headbonkache	f	saaa ft. MC iwata Bros.
838	Head BONK ache	FTR	9	9.4	1061	132-165	2:25	3.12	Nitro	空読無 白眼	headbonkache	f	saaa ft. MC iwata Bros.
840	DDD	PRS	6	6.5	484	138	1:58	3.12	én	わっふゑ	ddd	f	はがね
841	DDD	FTR	8	8.5	653	138	1:58	3.12	én	わっふゑ	ddd	f	はがね
842	Prism	PST	2	2	476	107-109	2:56	3.12	CERiNG	\N	prism	t	bermei.inazawa ft. Chata
843	Prism	PRS	5	5	544	107-109	2:56	3.12	CERiNG	\N	prism	t	bermei.inazawa ft. Chata
844	Prism	FTR	8	8	785	107-109	2:56	3.12	CERiNG	\N	prism	f	bermei.inazawa ft. Chata
845	Protoflicker	PST	3	3	510	140	2:48	3.12	antymis <prototype>	\N	protoflicker	t	Silentroom
846	Protoflicker	PRS	7	7	633	140	2:48	3.12	antymis <prototype>	\N	protoflicker	t	Silentroom
847	Protoflicker	FTR	9+	9.8	1042	140	2:48	3.12	antymis <prototype>	\N	protoflicker	f	Silentroom
848	Stasis	PST	4	4.5	848	180	2:34	3.12	東星	\N	stasis	t	Maozon
849	Stasis	PRS	7	7	935	180	2:34	3.12	東星	\N	stasis	t	Maozon
850	Stasis	FTR	10+	10.8	1521	180	2:34	3.12	東星	\N	stasis	f	Maozon
851	PICO-Pico-Translation!	PST	2	2	543	185	2:20	3.12	Translated by én	九鳥ぱんや & t+pazolite	picopicotranslation	f	t+pazolite,ななひら,Cranky,Pico*
852	PICO-Pico-Translation!	PRS	6	6	723	185	2:20	3.12	Translated by én	九鳥ぱんや & t+pazolite	picopicotranslation	f	t+pazolite,ななひら,Cranky,Pico*
853	PICO-Pico-Translation!	FTR	9	9.4	1049	185	2:20	3.12	Translated by én	九鳥ぱんや & t+pazolite	picopicotranslation	f	t+pazolite,ななひら,Cranky,Pico*
854	Dancin' on a Cat's Paw	PST	3	3	417	148	2:17	3.12	antymis	りゅうら + kkkfff2	nekonote	f	Ino(chronoize)
855	Dancin' on a Cat's Paw	PRS	6	6	593	148	2:17	3.12	antymis	りゅうら + kkkfff2	nekonote	f	Ino(chronoize)
856	Dancin' on a Cat's Paw	FTR	9	9.2	891	148	2:17	3.12	antymis	りゅうら + kkkfff2	nekonote	f	Ino(chronoize)
857	μ	PST	3	3.5	825	140-190	2:30	3.12	N↕TRO v1.0.5	Frums	mu	f	Frums
858	μ	PRS	7	7.5	986	140-190	2:30	3.12	N↕TRO v1.0.5	Frums	mu	f	Frums
859	μ	FTR	9+	9.7	1256	140-190	2:30	3.12	N↕TRO v1.0.5	Frums	mu	f	Frums
860	san skia	PST	3	3.5	670	170	2:47	3.12	CERiNG	Ancy	sanskia	f	ユアミトス
861	san skia	PRS	6	6	783	170	2:47	3.12	CERiNG	Ancy	sanskia	f	ユアミトス
862	san skia	FTR	8	8.3	1046	170	2:47	3.12	CERiNG	Ancy	sanskia	f	ユアミトス
49	Vexaria	BYD	9	9	785	180	2:12	3.0	石樂	Koyama Mai	vexaria	t	ak+q
50	Essence of Twilight	PST	4	4.5	556	164	2:31	1.0	Nitro	deel	essenceoftwilight	f	ak+q
51	Essence of Twilight	PRS	7	7	767	164	2:31	1.0	Nitro	deel	essenceoftwilight	f	ak+q
863	Altair (feat. *spiLa*)	PST	2	2.5	670	170	2:21	4.0	antymis	minamo + レク	altair	f	kamome sano & you
864	Altair (feat. *spiLa*)	PRS	6	6	828	170	2:21	4.0	antymis	minamo + レク	altair	f	kamome sano & you
865	Altair (feat. *spiLa*)	FTR	8	8.5	830	170	2:21	4.0	antymis	minamo + レク	altair	f	kamome sano & you
866	Redraw the Colorless World	PST	4	4	568	155	2:32	4.0	antymis ~無色~	\N	mukishitsu	f	MisomyL
867	Redraw the Colorless World	PRS	6	6.5	680	155	2:32	4.0	antymis ~彩色~	\N	mukishitsu	f	MisomyL
868	Redraw the Colorless World	FTR	9	9.4	886	155	2:32	4.0	antymis ~虹色~	\N	mukishitsu	f	MisomyL
869	Trap Crow	PST	4	4.5	876	80	2:54	4.0	CERiNG + Nitro	Khronetic	trapcrow	f	Puru
870	Trap Crow	PRS	7+	7.8	898	80	2:54	4.0	CERiNG + Nitro	Khronetic	trapcrow	f	Puru
871	Trap Crow	FTR	9+	9.9	1074	80	2:54	4.0	CERiNG + Nitro	Khronetic	trapcrow	f	Puru
872	PUPA	PST	4	4	374	202	2:07	4.0	én -胡蝶の夢-	yoshimo	pupa	f	モリモリあつし
873	PUPA	PRS	7+	7.8	684	202	2:07	4.0	én -胡蝶の夢-	yoshimo	pupa	f	モリモリあつし
874	PUPA	FTR	10	10.4	1099	202	2:07	4.0	én -胡蝶の夢-	yoshimo	pupa	f	モリモリあつし
875	Defection	PST	3	3.5	588	160	2:30	4.0	Monolith Incarnate	美和野らぐ	defection	f	TeddyLoid feat. DELTA
876	Defection	PRS	6	6.5	800	160	2:30	4.0	Monolith Incarnate	美和野らぐ	defection	f	TeddyLoid feat. DELTA
877	Defection	FTR	9+	9.8	1141	160	2:30	4.0	Monolith Incarnate	美和野らぐ	defection	f	TeddyLoid feat. DELTA
878	Infinite Strife,	PST	4	4	888	198	2:50	4.0	Inner Labyrinth	Enji	infinitestrife	f	BlackYooh vs. siromaru
879	Infinite Strife,	PRS	7	7.5	1081	198	2:50	4.0	Inner Labyrinth	Enji	infinitestrife	f	BlackYooh vs. siromaru
880	Infinite Strife,	FTR	9+	9.9	1511	198	2:50	4.0	Inner Labyrinth	Enji	infinitestrife	f	BlackYooh vs. siromaru
881	Infinite Strife,	BYD	10+	10.9	1633	198	2:50	4.0	Inner Labyrinth	Enji	infinitestrife	f	BlackYooh vs. siromaru
882	World Ender	PST	4	4	616	190-280	2:38	4.0	Imaginary Sky	米室	worldender	f	sasakure.UK × TJ.hangneil
883	World Ender	PRS	7+	7.8	850	190-280	2:38	4.0	Imaginary Sky	米室	worldender	f	sasakure.UK × TJ.hangneil
884	World Ender	FTR	10	10	1225	190-280	2:38	4.0	Imaginary Sky	米室	worldender	f	sasakure.UK × TJ.hangneil
885	World Ender	BYD	11	11.1	1661	190-280	2:38	4.0	Imaginary Sky	米室	worldender	f	sasakure.UK × TJ.hangneil
886	Pentiment	PST	7	7	911	200-222	2:43	4.0	Paradox Blight	村カルキ	pentiment	f	Nothing But Requiem with Museo
887	Pentiment	PRS	8+	8.7	1055	200-222	2:43	4.0	Paradox Blight	村カルキ	pentiment	f	Nothing But Requiem with Museo
888	Pentiment	FTR	10	10.4	1345	200-222	2:43	4.0	Paradox Blight	村カルキ	pentiment	f	Nothing But Requiem with Museo
889	Pentiment	BYD	11	11.5	1741	200-222	2:43	4.0	Paradox Blight	村カルキ	pentiment	f	Nothing But Requiem with Museo
890	Arcana Eden	PST	5	5.5	1097	211	3:00	4.0	Eye of the Storm	シエラ	arcanaeden	f	Team Grimoire vs Sakuzyo vs Laur
891	Arcana Eden	PRS	8+	8.7	1310	211	3:00	4.0	Eye of the Storm	シエラ	arcanaeden	f	Team Grimoire vs Sakuzyo vs Laur
892	Arcana Eden	FTR	10	10.5	1792	211	3:00	4.0	Eye of the Storm	シエラ	arcanaeden	f	Team Grimoire vs Sakuzyo vs Laur
893	Arcana Eden	BYD	11	11.6	2134	211	3:00	4.0	Eye of the Storm	シエラ	arcanaeden	f	Team Grimoire vs Sakuzyo vs Laur
894	Testify	PST	7+	7.8	1001	178	2:56	4.0	Eternal¦PAST	シエラ	testify	f	void (Mournfinale) feat. 星熊南巫
895	Testify	PRS	9	9.4	1225	178	2:56	4.0	Adverse¦PRESENT	シエラ	testify	f	void (Mournfinale) feat. 星熊南巫
896	Testify	FTR	10+	10.9	1766	178	2:56	4.0	Black¦FUTURE	シエラ	testify	f	void (Mournfinale) feat. 星熊南巫
897	Testify	BYD	12	12	2221	178	2:56	4.0	Silent¦END	シエラ	testify	f	void (Mournfinale) feat. 星熊南巫
898	Loveless Dress	PST	3	3.5	537	99	2:45	4.0	Final Prayer	Mechari	lovelessdress	f	かねこちはる
899	Loveless Dress	PRS	6	6.5	630	99	2:45	4.0	Final Prayer	Mechari	lovelessdress	f	かねこちはる
900	Loveless Dress	FTR	9+	9.7	850	99	2:45	4.0	Final Prayer	Mechari	lovelessdress	f	かねこちはる
902	Last	PRS	7	7	781	175	2:27	4.0	Arcaea	シエラ	last	f	onoken
903	Last	FTR	9	9	831	175	2:27	4.0	Arcaea	シエラ	last	f	onoken
904	Last | Moment	BYD	9	9.6	888	175	2:27	4.0	Arcaea	シエラ	last	t	onoken
908	Last | Eternity	BYD	9+	9.7	790	175	2:27	4.0	Arcaea	シエラ	lasteternity	f	onoken
909	Callima Karma	PST	3	3.5	1024	95	2:41	4.0	Forlorn Dream	がわこ	callimakarma	f	t+pazolite vs Feryquitous
910	Callima Karma	PRS	7	7.5	989	95	2:41	4.0	Forlorn Dream	がわこ	callimakarma	f	t+pazolite vs Feryquitous
911	Callima Karma	FTR	9+	9.8	1222	95	2:41	4.0	Forlorn Dream	がわこ	callimakarma	f	t+pazolite vs Feryquitous
912	Heart	PST	1	1	428	80	2:28	4.1	écologie (from SEGA)	\N	kokoro	f	削除 (Violin : Katali)
913	Heart	PRS	5	5	575	80	2:28	4.1	écologie (from SEGA)	\N	kokoro	f	削除 (Violin : Katali)
914	Heart	FTR	9	9.6	872	80	2:28	4.1	écologie (from SEGA)	\N	kokoro	f	削除 (Violin : Katali)
52	Essence of Twilight	FTR	9	9.1	1204	164	2:31	1.0	Nitro	deel	essenceoftwilight	f	ak+q
53	qualia -ideaesthesia-	PST	4	4.5	550	144	2:23	1.0	-chartaesthesia-	Khronetic	qualia	f	nitro
54	qualia -ideaesthesia-	PRS	7	7	875	144	2:23	1.0	-chartaesthesia-	Khronetic	qualia	f	nitro
915	Ai Drew	PST	3	3.5	694	175	2:17	4.1	moonquay【新入生】	\N	aidrew	f	Feryquitous
916	Ai Drew	PRS	6	6.5	732	175	2:17	4.1	moonquay v.EXPERT	\N	aidrew	f	Feryquitous
917	Ai Drew	FTR	9+	9.8	1066	175	2:17	4.1	moonquay v.MASTER	\N	aidrew	f	Feryquitous
918	FLUFFY FLASH	PST	3	3.5	787	252	2:27	4.1	Toaster	\N	fluffyflash	f	Kobaryo
919	FLUFFY FLASH	PRS	6	6.5	946	252	2:27	4.1	Toaster	\N	fluffyflash	f	Kobaryo
920	FLUFFY FLASH	FTR	9+	9.8	1329	252	2:27	4.1	Toaster	\N	fluffyflash	f	Kobaryo
921	Good bye, Merry-Go-Round.	PST	4	4.5	679	185	2:07	4.1	絶滅	\N	goodbyemerry	f	Yooh
922	Good bye, Merry-Go-Round.	PRS	7	7.5	696	185	2:07	4.1	絶滅	\N	goodbyemerry	f	Yooh
923	Good bye, Merry-Go-Round.	FTR	10	10.6	1084	185	2:07	4.1	絶滅	\N	goodbyemerry	f	Yooh
924	LAMIA	PST	5	5	826	199	2:26	4.1	夜浪	\N	lamia	f	BlackY
925	LAMIA	PRS	8	8.5	885	199	2:26	4.1	夜浪「ノブレス・オブリージュ」	\N	lamia	f	BlackY
926	LAMIA	FTR	11	11	1385	199	2:26	4.1	[漆黒の執行者] 夜浪	\N	lamia	f	BlackY
927	Free Myself	PST	4	4.5	662	153	2:33	4.1	Exschwasion	裕	freemyself	f	lapix feat. mami
928	Free Myself	PRS	7	7.5	785	153	2:33	4.1	Exschwasion	裕	freemyself	f	lapix feat. mami
929	Free Myself	FTR	10	10	1132	153	2:33	4.1	Exschwasion -unbound-	裕	freemyself	f	lapix feat. mami
930	cocoro*cosmetic	PST	3	3	525	144	2:42	4.1	Nitro	wacca	cocorocosmetic	f	KOTONOHOUSE
931	cocoro*cosmetic	PRS	7	7	687	144	2:42	4.1	Nitro	wacca	cocorocosmetic	f	KOTONOHOUSE
932	cocoro*cosmetic	FTR	9	9.2	1025	144	2:42	4.1	Nitro	wacca	cocorocosmetic	f	KOTONOHOUSE
933	Capella	PST	4	4.5	884	210	2:19	4.1	0°Nitro	シエラ	capella	f	ARForest
934	Capella	PRS	7+	7.8	904	210	2:19	4.1	0°Nitro	シエラ	capella	f	ARForest
935	Capella	FTR	10	10.2	1159	210	2:19	4.1	0°Nitro	シエラ	capella	f	ARForest
936	Dialnote	PST	3	3	393	130	2:01	4.1	Nitroです。	七草くりむ	dialnote	f	七草くりむ
937	Dialnote	PRS	6	6	548	130	2:01	4.1	Nitroです。	七草くりむ	dialnote	f	七草くりむ
938	Dialnote	FTR	8+	8.8	684	130	2:01	4.1	Nitroです。	七草くりむ	dialnote	f	七草くりむ
939	Tsuki ni Murakumo, Hana ni Kaze	PST	3	3	468	160	2:10	4.2	Lovely Visitor「Toaster」	\N	tsukinimurakumo	f	幽閉サテライト
940	Tsuki ni Murakumo, Hana ni Kaze	PRS	6	6	610	160	2:10	4.2	Lovely Visitor「Toaster」	\N	tsukinimurakumo	f	幽閉サテライト
941	Tsuki ni Murakumo, Hana ni Kaze	FTR	8+	8.7	740	160	2:10	4.2	Lovely Visitor「Toaster」	\N	tsukinimurakumo	f	幽閉サテライト
942	MANTIS (Arcaea Ultra-Bloodrush VIP)	PST	3	3	575	135	2:34	4.2	ANTyMIS	N²/ANTIREAL	mantis	f	Akira Complex feat. kiraku
943	MANTIS (Arcaea Ultra-Bloodrush VIP)	PRS	7	7	760	135	2:34	4.2	ANTyMIS	N²/ANTIREAL	mantis	f	Akira Complex feat. kiraku
944	MANTIS (Arcaea Ultra-Bloodrush VIP)	FTR	9	9.4	1014	135	2:34	4.2	ANTyMIS	N²/ANTIREAL	mantis	f	Akira Complex feat. kiraku
945	World Fragments III(radio edit)	PST	3	3.5	777	200	2:45	4.2	én	\N	worldfragments	f	xi
946	World Fragments III(radio edit)	PRS	7	7	999	200	2:45	4.2	én	\N	worldfragments	f	xi
947	World Fragments III(radio edit)	FTR	9+	9.8	1387	200	2:45	4.2	én supported by Nitro	\N	worldfragments	f	xi
948	Astra walkthrough	PST	4	4.5	769	225	2:21	4.2	Aster	八重幸	astrawalkthrough	f	paraoka
949	Astra walkthrough	PRS	7+	7.8	886	225	2:21	4.2	Aster	八重幸	astrawalkthrough	f	paraoka
950	Astra walkthrough	FTR	9+	9.9	1191	225	2:21	4.2	Aster join Toaster.	八重幸	astrawalkthrough	f	paraoka
951	Chronicle	PST	5	5	928	221	2:25	4.2	夜浪 -Annales Historiae-	fixro2n	chronicle	f	Lime
952	Chronicle	PRS	8+	8.9	1077	221	2:25	4.2	夜浪 -Annales Historiae-	fixro2n	chronicle	f	Lime
953	Chronicle	FTR	10	10.5	1264	221	2:25	4.2	夜浪 -Annales Historiae-	fixro2n	chronicle	f	Lime
954	NULL APOPHENIA	PST	4	4.5	990	177	3:03	4.2	夜浪	softmode	nullapophenia	f	N²
955	NULL APOPHENIA	PRS	8+	8.8	1098	177	3:03	4.2	夜浪	softmode	nullapophenia	f	N²
956	NULL APOPHENIA	FTR	10+	10.7	1299	177	3:03	4.2	東星 vs 夜浪《APOPHÄNIE》	softmode	nullapophenia	f	N²
957	Crimson Throne	PST	4	4	727	210	2:15	4.3	Toaster	nonokuro	crimsonthrone	f	Dimier√Lisb
958	Crimson Throne	PRS	8	8	1079	210	2:15	4.3	Toaster	nonokuro	crimsonthrone	f	Dimier√Lisb
959	Crimson Throne	FTR	10	10.6	1313	210	2:15	4.3	Toaster	nonokuro	crimsonthrone	f	Dimier√Lisb
960	Manic Jeer	PST	4	4	698	195	2:32	4.3	NITR<O>	トロ３	manicjeer	f	ルゼ
961	Manic Jeer	PRS	7+	7.8	875	195	2:32	4.3	NITR<O>	トロ３	manicjeer	f	ルゼ
962	Manic Jeer	FTR	10	10.6	1286	195	2:32	4.3	NITR<O>	トロ３	manicjeer	f	ルゼ
963	Hiiro Gekka, Kyoushou no Zetsu (nayuta 2017 ver.)	PST	3	3.5	719	150	2:40	4.3	絶滅 Exschwasion 絶滅 Exschwasion	ぃやまと	hiirogekka	f	nayuta x 黒鳥(EastNewSound)
964	Hiiro Gekka, Kyoushou no Zetsu (nayuta 2017 ver.)	PRS	6	6.5	709	150	2:40	4.3	絶滅 Exschwasion 絶滅 Exschwasion	ぃやまと	hiirogekka	f	nayuta x 黒鳥(EastNewSound)
55	qualia -ideaesthesia-	FTR	9	9.1	1022	144	2:23	1.0	-chartaesthesia-	Khronetic	qualia	f	nitro
56	qualia -ideaesthesia-	BYD	9+	9.8	1288	144	2:23	3.10	moonquay -end of chartaesthesia-	khronetic -synesthesia-	qualia	t	nitro
57	PRAGMATISM	PST	4	4.5	476	174	2:00	1.0	東星	シエラ	pragmatism	f	Laur
965	Hiiro Gekka, Kyoushou no Zetsu (nayuta 2017 ver.)	FTR	10	10.3	1126	150	2:40	4.3	絶滅 Exschwasion 絶滅 Exschwasion	ぃやまと	hiirogekka	f	nayuta x 黒鳥(EastNewSound)
966	Let's Rock (Arcaea mix)	PST	3	3	541	210	2:27	4.3	Luxance	虎硬 + 無想りんね	letsrock	f	ikaruga_nex vs FALCHiON
967	Let's Rock (Arcaea mix)	PRS	7	7	963	210	2:27	4.3	Luxance	虎硬 + 無想りんね	letsrock	f	ikaruga_nex vs FALCHiON
968	Let's Rock (Arcaea mix)	FTR	9+	9.7	1177	210	2:27	4.3	Luxance	虎硬 + 無想りんね	letsrock	f	ikaruga_nex vs FALCHiON
969	CYCLES	PST	2	2	389	135	2:01	4.3	Nitro	\N	cycles	f	Masayoshi Minoshima feat. 綾倉盟
970	CYCLES	PRS	5	5	430	135	2:01	4.3	N-Helix	\N	cycles	f	Masayoshi Minoshima feat. 綾倉盟
971	CYCLES	FTR	8+	8.8	695	135	2:01	4.3	N-Helix	\N	cycles	f	Masayoshi Minoshima feat. 綾倉盟
972	MAXRAGE	PST	3	3.5	696	222	2:13	4.3	EXSCHWASION	\N	maxrage	f	EBIMAYO
973	MAXRAGE	PRS	6	6.5	760	222	2:13	4.3	EXSCHWASION	\N	maxrage	f	EBIMAYO
974	MAXRAGE	FTR	9+	9.9	1184	222	2:13	4.3	EXSCHWASION	\N	maxrage	f	EBIMAYO
975	[X]	PST	4	4.5	594	162-180	2:25	4.3	Nitro	\N	infinity	f	Blacklolita
976	[X]	PRS	7+	7.8	782	162-180	2:25	4.3	Nitro	\N	infinity	f	Blacklolita
977	[X]	FTR	10	10.6	1190	162-180	2:25	4.3	東星	\N	infinity	f	Blacklolita
978	TEmPTaTiON	PST	5	5	627	160	2:21	4.3	EXtINcTiON	\N	temptation	f	かねこちはる
979	TEmPTaTiON	PRS	8	8.2	768	160	2:21	4.3	EXtINcTiON	\N	temptation	f	かねこちはる
980	TEmPTaTiON	FTR	10+	10.9	1099	160	2:21	4.3	EXtINcTiON	\N	temptation	f	かねこちはる
981	PRIMITIVE LIGHTS	PST	5	5.5	785	205	2:44	4.3	東星※原初の灯	Waterswing	primitivelights	f	TAG
982	PRIMITIVE LIGHTS	PRS	8+	8.8	1073	205	2:44	4.3	東星※原初の灯	Waterswing	primitivelights	f	TAG
983	PRIMITIVE LIGHTS	FTR	10+	10.8	1524	205	2:44	4.3	東星※原初の灯	Waterswing	primitivelights	f	TAG
984	Cosmo Pop Funclub	PST	2	2.5	352	129	2:22	4.4	Nitro NEW!!	\N	cosmopop	f	ナユタン星人
985	Cosmo Pop Funclub	PRS	6	6	591	129	2:22	4.4	Nitro NEW!!	\N	cosmopop	f	ナユタン星人
986	Cosmo Pop Funclub	FTR	8+	8.8	809	129	2:22	4.4	Nitro NEW!!	\N	cosmopop	f	ナユタン星人
987	IMPACT	PST	3	3.5	723	210	2:30	4.4	ÉCOLOGIE IMPACT	\N	impact	f	USAO feat. 光吉猛修
988	IMPACT	PRS	7+	7.8	913	210	2:30	4.4	ÉN IMPACT	\N	impact	f	USAO feat. 光吉猛修
989	IMPACT	FTR	9	9.6	1231	210	2:30	4.4	én feat. écologie	\N	impact	f	USAO feat. 光吉猛修
990	IMPACT	BYD	10	10.4	1392	210	2:30	4.4	Toaster NEW!!	\N	impact	f	USAO feat. 光吉猛修
991	Genesis	PST	4	4	587	150	2:04	4.4	Exschwasion	\N	genesischunithm	f	Morrigan feat.Lily
992	Genesis	PRS	7	7	838	150	2:04	4.4	Exschwasion	\N	genesischunithm	f	Morrigan feat.Lily
993	Genesis	FTR	9+	9.8	867	150	2:04	4.4	Exschwasion	\N	genesischunithm	f	Morrigan feat.Lily
994	Trrricksters!!	PST	4	4.5	561	155	2:27	4.4	絶滅	\N	trrricksters	f	s-don vs. 翡乃イスカ
995	Trrricksters!!	PRS	7	7.5	784	155	2:27	4.4	絶滅	\N	trrricksters	f	s-don vs. 翡乃イスカ
996	Trrricksters!!	FTR	10	10.1	1183	155	2:27	4.4	絶滅	\N	trrricksters	f	s-don vs. 翡乃イスカ
997	Spider's Thread	PST	4	4.5	794	180	2:21	4.4	夜浪 <->	\N	spidersthread	f	きくお×cosMo＠暴走P feat.影縫英
998	Spider's Thread	PRS	7+	7.8	764	180	2:21	4.4	夜浪 <->	\N	spidersthread	f	きくお×cosMo＠暴走P feat.影縫英
999	Spider's Thread	FTR	10+	10.8	1203	180	2:21	4.4	夜浪 <->	\N	spidersthread	f	きくお×cosMo＠暴走P feat.影縫英
1000	Lost Emotion feat. nomico	PST	3	3.5	602	172	2:40	4.4	ポーカーフェイスのToaster	SoU(wavforme)	lostemotion	f	Masayoshi Minoshima(ALR)
1001	Lost Emotion feat. nomico	PRS	7	7	780	172	2:40	4.4	ポーカーフェイスのToaster	SoU(wavforme)	lostemotion	f	Masayoshi Minoshima(ALR)
1002	Lost Emotion feat. nomico	FTR	9	9.3	1123	172	2:40	4.4	ポーカーフェイスのToaster	SoU(wavforme)	lostemotion	f	Masayoshi Minoshima(ALR)
1003	GIMMICK	PST	2	2.5	421	143	2:04	4.4	Nitro	\N	gimmick	f	Ms.Sill
1004	GIMMICK	PRS	6	6.5	598	143	2:04	4.4	Nitro	\N	gimmick	f	Ms.Sill
1005	GIMMICK	FTR	9	9.5	733	143	2:04	4.4	antymis + Nitro	\N	gimmick	f	Ms.Sill
1006	The Survivor (Game Edit)	PST	3	3.5	817	132	3:10	4.4	Nitro	12d	thesurvivor	f	Taishi
1007	The Survivor (Game Edit)	PRS	6	6.5	750	132	3:10	4.4	Nitro	12d	thesurvivor	f	Taishi
1008	The Survivor (Game Edit)	FTR	9+	9.9	1100	132	3:10	4.4	Nitro	12d	thesurvivor	f	Taishi
1009	New York Back Raise	PST	4	4.5	762	160	2:31	4.4	Exschwasion 「CHECK」	すずあ	newyorkbackraise	f	saaa + kei_iwata + stuv + わかどり
1010	New York Back Raise	PRS	7	7	803	160	2:31	4.4	Exschwasion 「RAISE」	すずあ	newyorkbackraise	f	saaa + kei_iwata + stuv + わかどり
1011	New York Back Raise	FTR	9+	9.9	1091	160	2:31	4.4	Exschwasion 「ALL IN」	すずあ	newyorkbackraise	f	saaa + kei_iwata + stuv + わかどり
1012	Galactic Love	PST	3	3	513	145	2:42	4.4	én	\N	galacticlove	f	La prière
58	PRAGMATISM	PRS	8	8.6	855	174	2:00	1.0	東星	シエラ	pragmatism	f	Laur
59	PRAGMATISM	FTR	10	10.1	942	174	2:00	1.0	東星	シエラ	pragmatism	f	Laur
60	PRAGMATISM -RESURRECTION-	BYD	11	11.2	1502	174	2:00	3.10	THE LAST DREAM	シエラ	pragmatism	t	Laur
1013	Galactic Love	PRS	6	6.5	694	145	2:42	4.4	én	\N	galacticlove	f	La prière
1014	Galactic Love	FTR	9	9	813	145	2:42	4.4	én	\N	galacticlove	f	La prière
1015	Lawless Point	PST	3	3	476	148	2:36	4.4	Luxance	\N	lawlesspoint	f	La prière
1016	Lawless Point	PRS	6	6	630	148	2:36	4.4	Luxance	\N	lawlesspoint	f	La prière
1017	Lawless Point	FTR	9	9	838	148	2:36	4.4	Luxance	\N	lawlesspoint	f	La prière
1018	Lost in the Abyss	PST	3	3.5	907	183	2:48	4.4	Nitro	AO	lostintheabyss	f	FELT
1019	Lost in the Abyss	PRS	6	6.5	908	183	2:48	4.4	Nitro	AO	lostintheabyss	f	FELT
1020	Lost in the Abyss	FTR	9+	9.7	1179	183	2:48	4.4	Nitro	AO	lostintheabyss	f	FELT
1021	Hybris (The one who shattered)	PST	4	4.5	757	158	2:42	4.4	Exschwasion	\N	hybris	f	qfeileadh feat.のあ
1022	Hybris (The one who shattered)	PRS	7+	7.8	973	158	2:42	4.4	Exschwasion	\N	hybris	f	qfeileadh feat.のあ
1023	Hybris (The one who shattered)	FTR	9+	9.8	1196	158	2:42	4.4	Exschwasion	\N	hybris	f	qfeileadh feat.のあ
1024	To the Milky Way	PST	5	5	928	186	2:46	4.4	Nitroだー！	Bison	tothemilkyway	f	黒魔
1025	To the Milky Way	PRS	8+	8.9	1154	186	2:46	4.4	Nitroだー！	Bison	tothemilkyway	f	黒魔
1026	To the Milky Way	FTR	10	10.4	1392	186	2:46	4.4	Nitroだー！	Bison	tothemilkyway	f	黒魔
1027	INTERNET YAMERO	PST	4	4.5	677	185	3:01	4.5	該当チャンネルが停止されたため、\nこの譜面は再生できません。	\N	internetyamero	f	Aiobahn feat. KOTOKO
1028	INTERNET YAMERO	PRS	7+	7.8	987	185	3:01	4.5	該当チャンネルが停止されたため、\nこの譜面は再生できません。	\N	internetyamero	f	Aiobahn feat. KOTOKO
1029	INTERNET YAMERO	FTR	10	10	1222	185	3:01	4.5	該当チャンネルが停止されたため、\nこの譜面は再生できません。	\N	internetyamero	f	Aiobahn feat. KOTOKO
1030	Bullet Waiting for Me (James Landino remix)	PST	2	2.5	325	107	2:30	4.5	CERiNG	\N	bulletwaiting	f	Nikki Simmons
1031	Bullet Waiting for Me (James Landino remix)	PRS	4	4.5	390	107	2:30	4.5	CERiNG	\N	bulletwaiting	f	Nikki Simmons
1032	Bullet Waiting for Me (James Landino remix)	FTR	8	8.1	701	107	2:30	4.5	CERiNG	\N	bulletwaiting	f	Nikki Simmons
1033	Devillic Sphere	PST	4	4	490	160	2:06	4.5	₸öα$†ε₹	\N	devillicsphere	f	3R2
1034	Devillic Sphere	PRS	7+	7.8	692	160	2:06	4.5	₸öα$†ε₹	\N	devillicsphere	f	3R2
1035	Devillic Sphere	FTR	9+	9.9	1129	160	2:06	4.5	₸öα$†ε₹	\N	devillicsphere	f	3R2
1036	Lucid Traveler	PST	4	4.5	634	170-200	2:39	4.5	Toaster vs ₸öα$†ε₹	NC帝國	lucidtraveler	f	Akira Complex vs 3R2
1037	Lucid Traveler	PRS	8+	8.9	1006	170-200	2:39	4.5	Toaster vs ₸öα$†ε₹	NC帝國	lucidtraveler	f	Akira Complex vs 3R2
1038	Lucid Traveler	FTR	10	10.5	1341	170-200	2:39	4.5	Toaster vs ₸öα$†ε₹	NC帝國	lucidtraveler	t	Akira Complex vs 3R2
1039	CHAOS	PST	5	5.5	646	150	2:49	4.5	絶滅	\N	chaos	f	Æsir
1040	CHAOS	PRS	7	7.5	848	150	2:49	4.5	絶滅	\N	chaos	f	Æsir
1041	CHAOS	FTR	10+	10.9	1369	150	2:49	4.5	絶滅	\N	chaos	f	Æsir
1042	Used to be	PST	4	4	537	140	3:06	4.5	Luxance	\N	usedtobe	f	KIVΛ
1043	Used to be	PRS	6	6.5	675	140	3:06	4.5	Luxance	\N	usedtobe	f	KIVΛ
1044	Used to be	FTR	9	9.2	799	140	3:06	4.5	Luxance + Nitro	\N	usedtobe	f	KIVΛ
1045	Ultimate taste	PST	3	3.5	828	200	2:55	4.6	Arcaea Charting Team	ぱらどっと	ultimatetaste	f	ぱらどっと
1046	Ultimate taste	PRS	6	6.5	1008	200	2:55	4.6	Arcaea Charting Team	ぱらどっと	ultimatetaste	f	ぱらどっと
1047	Ultimate taste	FTR	9+	9.9	1405	200	2:55	4.6	Arcaea Charting Team【Full Flavor】	ぱらどっと	ultimatetaste	f	ぱらどっと
1048	syūten	PST	2	2	395	76-96	2:28	4.6	antymīs	\N	syuten	f	Apo11o"COLLAPSAR"program ft. 大瀬良あい
1049	syūten	PRS	5	5	446	76-96	2:28	4.6	antymīs	\N	syuten	f	Apo11o"COLLAPSAR"program ft. 大瀬良あい
1050	syūten	FTR	8	8.5	592	76-96	2:28	4.6	antymīs	\N	syuten	f	Apo11o"COLLAPSAR"program ft. 大瀬良あい
1051	DRG	PST	3	3.5	380	155	1:58	4.6	_NITRO	\N	drg	f	onoken
1052	DRG	PRS	7	7	624	155	1:58	4.6	_HARD	\N	drg	f	onoken
1053	DRG	FTR	9	9.4	872	155	1:58	4.6	_CHAOS	\N	drg	f	onoken
1054	99 Glooms	PST	4	4	637	185	2:42	4.6	終点	\N	nnglooms	f	Sta
1055	99 Glooms	PRS	7+	7.8	774	185	2:42	4.6	終点	\N	nnglooms	f	Sta
1056	99 Glooms	FTR	10	10.3	1294	185	2:42	4.6	終点	\N	nnglooms	f	Sta
1057	 ͟͝͞Ⅱ́̕ 	PST	5	5	690	130-150	2:44	4.6	Corrupted data\nRecovery progress......100%	\N	ii	t	Cytus
1058	 ͟͝͞Ⅱ́̕ 	PRS	8+	8.9	816	130-150	2:44	4.6	Main_Log_702_10_25	\N	ii	t	Cytus
1059	 ͟͝͞Ⅱ́̕ 	FTR	10+	10.8	1051	130-150	2:44	4.6	Cam_Library_702_12_29	\N	ii	f	Cytus
1060	Magnolia	PST	4	4.5	625	160	2:25	4.6	Lacrimosa	\N	magnolia	f	M2U Vocal by Guriri
1061	Magnolia	PRS	7+	7.8	726	160	2:25	4.6	Lacrimosa	\N	magnolia	f	M2U Vocal by Guriri
1062	Magnolia	FTR	10	10.2	895	160	2:25	4.6	Lacrimosa	\N	magnolia	f	M2U Vocal by Guriri
61	Sheriruth	PST	5	5.5	611	185	2:17	1.0	夜浪	シエラ	sheriruth	f	Team Grimoire
62	Sheriruth	PRS	7	7.5	832	185	2:17	1.0	夜浪	シエラ	sheriruth	f	Team Grimoire
63	Sheriruth	FTR	10	10	1151	185	2:17	1.0	夜浪	シエラ	sheriruth	f	Team Grimoire
1063	SACRIFICE feat. ayame	PST	3	3.5	548	180	2:14	4.7	Luxance	宵野コタロー + SoU(wavforme)	sacrifice	f	Masayoshi Minoshima(ALR)
1064	SACRIFICE feat. ayame	PRS	7	7.5	779	180	2:14	4.7	Luxance	宵野コタロー + SoU(wavforme)	sacrifice	f	Masayoshi Minoshima(ALR)
1065	SACRIFICE feat. ayame	FTR	9+	9.7	958	180	2:14	4.7	Luxance	宵野コタロー + SoU(wavforme)	sacrifice	f	Masayoshi Minoshima(ALR)
1066	RGB	PST	4	4	652	163	2:40	4.7	NO₂	いわこ脳	rgb	f	MEMODEMO X AQUASINE
1067	RGB	PRS	7+	7.8	803	163	2:40	4.7	NO₂	いわこ脳	rgb	f	MEMODEMO X AQUASINE
1068	RGB	FTR	9+	9.8	1131	163	2:40	4.7	NO₂	いわこ脳	rgb	f	MEMODEMO X AQUASINE
1069	WAIT FOR DAWN	PST	2	2.5	596	188	2:11	4.7	én	子期安NANA_ANN	waitfordawn	f	U-ske feat. 棗いつき
1070	WAIT FOR DAWN	PRS	7+	7.8	636	188	2:11	4.7	én	子期安NANA_ANN	waitfordawn	f	U-ske feat. 棗いつき
1071	WAIT FOR DAWN	FTR	8+	8.7	861	188	2:11	4.7	én	子期安NANA_ANN	waitfordawn	f	U-ske feat. 棗いつき
1072	Raven's Pride	PST	3	3	697	165	2:31	4.7	Exschwasion	めとこ	ravenspride	f	みーに feat. はらもりよしな
1073	Raven's Pride	PRS	7	7	797	165	2:31	4.7	Exschwasion	めとこ	ravenspride	f	みーに feat. はらもりよしな
1074	Raven's Pride	FTR	9	9.4	1030	165	2:31	4.7	Exschwasion	めとこ	ravenspride	f	みーに feat. はらもりよしな
1075	Rise of the World	PST	4	4.5	722	182-212	2:20	4.7	N⇑TRO	Asgard	riseoftheworld	f	cosMo＠暴走P
1076	Rise of the World	PRS	8	8.1	843	182-212	2:20	4.7	N⇑TRO	Asgard	riseoftheworld	f	cosMo＠暴走P
1077	Rise of the World	FTR	10	10.5	1176	182-212	2:20	4.7	N⇑TRO	Asgard	riseoftheworld	f	cosMo＠暴走P
1078	UNKNOWN LEVELS	PST	4	4	591	110-165	2:35	4.7	Toaster	ひと和	unknownlevels	f	Yuta Imai
1079	UNKNOWN LEVELS	PRS	8	8.1	771	110-165	2:35	4.7	Toaster	ひと和	unknownlevels	f	Yuta Imai
1080	UNKNOWN LEVELS	FTR	10	10.6	1149	110-165	2:35	4.7	⇓ 東星 vs Toaster ⇓	ひと和	unknownlevels	f	Yuta Imai
1081	Abstruse Dilemma	PST	5	5.5	983	216	2:41	4.7	Remnant ⇐ Guilt	おぐち	abstrusedilemma	f	Ashrount vs. 打打だいず
1082	Abstruse Dilemma	PRS	8+	8.9	1127	216	2:41	4.7	Remnant ⇒ Doubt	おぐち	abstrusedilemma	f	Ashrount vs. 打打だいず
1083	Abstruse Dilemma	FTR	11	11.3	1467	216	2:41	4.7	Remnant ⇑⇓ Volition	おぐち	abstrusedilemma	f	Ashrount vs. 打打だいず
1084	Kanjou no Matenrou ～Arr.Demetori	PST	3	3.5	736	178	2:33	4.7	Exschwasion	\N	matenrou	f	Demetori
1085	Kanjou no Matenrou ～Arr.Demetori	PRS	6	6.5	929	178	2:33	4.7	Exschwasion	\N	matenrou	f	Demetori
1086	Kanjou no Matenrou ～Arr.Demetori	FTR	9+	9.8	1294	178	2:33	4.7	N•Ex•T	\N	matenrou	f	Demetori
1087	To the Furthest Dream	PST	4	4.5	836	183	2:36	4.7	\N	Bison	tothefurthestdream	t	ii/night feat. 綺良雪
1088	To the Furthest Dream	PRS	8	8.5	994	183	2:36	4.7	\N	Bison	tothefurthestdream	t	ii/night feat. 綺良雪
1089	To the Furthest Dream	FTR	9+	9.8	1102	183	2:36	4.7	\N	Bison	tothefurthestdream	f	ii/night feat. 綺良雪
1090	Remind the Souls (Short Version)	PST	3	3.5	561	130	2:39	5.0	Nitro	\N	remindthesouls	f	Nhato
1091	Remind the Souls (Short Version)	PRS	7	7	756	130	2:39	5.0	Nitro	\N	remindthesouls	f	Nhato
1092	Remind the Souls (Short Version)	FTR	9	9.6	945	130	2:39	5.0	Nitro	\N	remindthesouls	f	Nhato
1093	Dynitikós	PST	4	4	683	180	2:34	5.0	Exschwasión	AT基調	dynitikos	f	Prower
1094	Dynitikós	PRS	7	7.5	894	180	2:34	5.0	Exschwasión	AT基調	dynitikos	f	Prower
1095	Dynitikós	FTR	9	9.5	986	180	2:34	5.0	Exschwasión	AT基調	dynitikos	f	Prower
1096	Amekagura	PST	4	4	741	105	2:13	5.0	antymis	英エイスト	amekagura	f	荒谷サトル
1097	Amekagura	PRS	7	7.5	851	105	2:13	5.0	antymis	英エイスト	amekagura	f	荒谷サトル
1098	Amekagura	FTR	9+	9.9	1076	105	2:13	5.0	antymis	英エイスト	amekagura	f	荒谷サトル
1099	B.B.K.K.B.K.K.	PST	4	4.5	669	170	2:08	5.0	E.E.X.X.E.X.X.	\N	bbkkbkk	f	nora2r
1100	B.B.K.K.B.K.K.	PRS	7	7	708	170	2:08	5.0	E.E.X.X.E.X.X.	\N	bbkkbkk	f	nora2r
1101	B.B.K.K.B.K.K.	FTR	9+	9.7	976	170	2:08	5.0	E.E.X.X.E.X.X.	\N	bbkkbkk	f	nora2r
1102	Primeval Texture	PST	3	3	387	120	2:13	5.0	CERiNG	LOWRISE	primevaltexture	f	くるぶっこちゃん
1103	Primeval Texture	PRS	7	7.5	525	120	2:13	5.0	CERiNG	LOWRISE	primevaltexture	f	くるぶっこちゃん
1104	Primeval Texture	FTR	9	9	810	120	2:13	5.0	CERiNG	LOWRISE	primevaltexture	f	くるぶっこちゃん
1105	Technicolour	PST	3	3.5	644	175	2:31	5.0	KLMNOP	Keizou	technicolour	f	Maozon
1106	Technicolour	PRS	7	7	812	175	2:31	5.0	KLMNOP	Keizou	technicolour	f	Maozon
1107	Technicolour	FTR	9+	9.8	1140	175	2:31	5.0	KLMNOP	Keizou	technicolour	f	Maozon
1108	Logos	PST	4	4	697	189	2:17	5.0	絶滅	majamari	logos	f	polysha feat. 高城みよ
1109	Logos	PRS	7+	7.8	798	189	2:17	5.0	絶滅	majamari	logos	f	polysha feat. 高城みよ
1110	Logos	FTR	10	10.2	1040	189	2:17	5.0	絶滅	majamari	logos	f	polysha feat. 高城みよ
1111	Ego Eimi	PST	5	5.5	801	178	2:35	5.0	東星	Khronetic - At the Horizon	egoeimi	f	BlackY feat. Risa Yuzuki
64	Lumia	PST	2	2.5	469	180	2:03	1.0	Nitro	mins	lumia	f	sky_delta
65	Lumia	PRS	5	5.5	438	180	2:03	1.0	Nitro	mins	lumia	f	sky_delta
66	Lumia	FTR	8	8.4	961	180	2:03	1.0	Toaster missing Nitro.	mins	lumia	f	sky_delta
1112	Ego Eimi	PRS	8	8.6	937	178	2:35	5.0	東星	Khronetic - At the Horizon	egoeimi	f	BlackY feat. Risa Yuzuki
1113	Ego Eimi	FTR	10	10.5	1223	178	2:35	5.0	東星	Khronetic - At the Horizon	egoeimi	f	BlackY feat. Risa Yuzuki
1114	Arghena	PST	7	7.5	883	185	2:33	5.0	第一識 "Reality"	すずなし	arghena	f	Feryquitous vs Laur
1115	Arghena	PRS	9	9.6	1082	185	2:33	5.0	第二識 "Causality"	すずなし	arghena	f	Feryquitous vs Laur
1116	Arghena	FTR	11	11.3	1444	185	2:33	5.0	第三識 "Pluriversality"	すずなし	arghena	f	Feryquitous vs Laur
1117	FANTA5Y	PST	3	3	536	170	2:22	5.1	TOA5TIE	nep	fantasy	f	Moon Jelly & YUKIYANAGI
1118	FANTA5Y	PRS	7	7	715	170	2:22	5.1	TOA5TIE	nep	fantasy	f	Moon Jelly & YUKIYANAGI
1119	FANTA5Y	FTR	9	9.4	965	170	2:22	5.1	TOA5TIE	nep	fantasy	f	Moon Jelly & YUKIYANAGI
1120	Transient Space	PST	2	2.5	419	115-132	2:38	5.1	CERiNG -liminal-	PAZZi	transientspace	f	sleepless, Gardens, aspect
1121	Transient Space	PRS	7	7	607	115-132	2:38	5.1	CERiNG -liminal-	PAZZi	transientspace	f	sleepless, Gardens, aspect
1122	Transient Space	FTR	9	9.5	805	115-132	2:38	5.1	CERiNG -liminal-	PAZZi	transientspace	f	sleepless, Gardens, aspect
1123	Nameless Passion	PST	3	3	681	200	2:37	5.1	Luxance	こたろう	namelesspassion	f	天束 feat.Sennzai
1124	Nameless Passion	PRS	7	7	890	200	2:37	5.1	Luxance	こたろう	namelesspassion	f	天束 feat.Sennzai
1125	Nameless Passion	FTR	9+	9.8	1223	200	2:37	5.1	Luxance	こたろう	namelesspassion	f	天束 feat.Sennzai
1126	TeraVolt	PST	5	5	675	154	2:22	5.1	夜浪	hiro	teravolt	f	Katali
1127	TeraVolt	PRS	8+	8.9	804	154	2:22	5.1	夜浪	hiro	teravolt	f	Katali
1128	TeraVolt	FTR	10+	10.8	1008	154	2:22	5.1	超東星 × 雷夜浪	hiro	teravolt	f	Katali
1129	Stratoliner	PST	3	3.5	535	175	2:05	5.2	Exschwasion	\N	stratoliner	f	C-Show
1130	Stratoliner	PRS	6	6.5	702	175	2:05	5.2	Exschwasion	\N	stratoliner	f	C-Show
1131	Stratoliner	FTR	9	9.6	877	175	2:05	5.2	Exschwasion	\N	stratoliner	f	C-Show
1132	Ouvertüre	PST	2	2.5	583	200	2:21	5.2	るくあんす	\N	ouverture	f	USAO & DJ Genki feat. ルーン(CV:河瀬茉希)
1133	Ouvertüre	PRS	7	7.5	786	200	2:21	5.2	るくあんす	\N	ouverture	f	USAO & DJ Genki feat. ルーン(CV:河瀬茉希)
1134	Ouvertüre	FTR	9+	9.8	913	200	2:21	5.2	るくあんす	\N	ouverture	f	USAO & DJ Genki feat. ルーン(CV:河瀬茉希)
1135	XTREME	PST	4	4.5	752	205	2:20	5.2	絶滅	\N	xtreme	f	USAO
1136	XTREME	PRS	7+	7.8	831	205	2:20	5.2	絶滅	\N	xtreme	f	USAO
1137	XTREME	FTR	10	10.5	1258	205	2:20	5.2	絶滅	\N	xtreme	f	USAO
1138	eden	PST	4	4.5	826	246	2:23	5.2	反水	\N	edenwacca	f	"漆黒"の堕天使《Gram》†Versus†"聖刻"の熾天使《Gram》
1139	eden	PRS	8	8.2	1194	246	2:23	5.2	反水	\N	edenwacca	f	"漆黒"の堕天使《Gram》†Versus†"聖刻"の熾天使《Gram》
1140	eden	FTR	10	10.5	1365	246	2:23	5.2	反水	\N	edenwacca	f	"漆黒"の堕天使《Gram》†Versus†"聖刻"の熾天使《Gram》
1141	Meta-Mysteria	PST	5	5	844	205	2:27	5.2	夜浪	Taiyo Yamamoto	metamysteria	f	DJ Noriken
1142	Meta-Mysteria	PRS	7+	7.8	905	205	2:27	5.2	夜浪	Taiyo Yamamoto	metamysteria	f	DJ Noriken
1143	Meta-Mysteria	FTR	10+	10.8	1309	205	2:27	5.2	VII: THE CHARIOT/夜浪	Taiyo Yamamoto	metamysteria	f	DJ Noriken
1144	Alone & Lorn	PST	3	3	643	100	2:19	5.2	én	のり恋	aloneandlorn	f	Ponchi♪ feat.はぁち
1145	Alone & Lorn	PRS	6	6.5	742	100	2:19	5.2	én	のり恋	aloneandlorn	f	Ponchi♪ feat.はぁち
1146	Alone & Lorn	FTR	9	9.6	970	100	2:19	5.2	én & KLMNOP	のり恋	aloneandlorn	f	Ponchi♪ feat.はぁち
1147	Wish Upon a Snow	PST	4	4.5	1031	218	2:39	5.2	0°絶滅	桶乃かもく	wishuponasnow	f	打打だいず
1148	Wish Upon a Snow	PRS	7	7.5	1095	218	2:39	5.2	0°絶滅	桶乃かもく	wishuponasnow	f	打打だいず
1149	Wish Upon a Snow	FTR	10	10.5	1309	218	2:39	5.2	0°絶滅	桶乃かもく	wishuponasnow	f	打打だいず
1150	Kanbu de Tomatte Sugu Tokeru	PST	4	4	584	200	2:13	5.2	C7H11NO配合!!!!!!	モタ	overdrive	f	ARM＋夕野ヨシミ (IOSYS) feat. miko
1151	Kanbu de Tomatte Sugu Tokeru	PRS	7	7.5	714	200	2:13	5.2	C7H11NO配合!!!!!!	モタ	overdrive	f	ARM＋夕野ヨシミ (IOSYS) feat. miko
1152	Kanbu de Tomatte Sugu Tokeru	FTR	10	10.1	1108	200	2:13	5.2	C7H11NO配合!!!!!!	モタ	overdrive	f	ARM＋夕野ヨシミ (IOSYS) feat. miko
1153	felys final remix	PST	3	3	626	180	2:50	5.2	Dec18	Ta-k	felys	f	onoken
1154	felys final remix	PRS	6	6.5	771	180	2:50	5.2	Dec18	Ta-k	felys	f	onoken
1155	felys final remix	FTR	9	9.5	1130	180	2:50	5.2	Dec18	Ta-k	felys	f	onoken
1156	On And On!! feat. Jenga	PST	3	3	370	170	2:00	5.2	én and én!!	Keizou	onandon	f	ETIA.
1157	On And On!! feat. Jenga	PRS	7	7	616	170	2:00	5.2	én and én!!	Keizou	onandon	f	ETIA.
1158	On And On!! feat. Jenga	FTR	9	9.5	836	170	2:00	5.2	én and én!!	Keizou	onandon	f	ETIA.
1159	LIVHT MY WΔY	PST	4	4.5	673	190	2:01	5.2	k//eternal + nitro\n"ephemeral past"	fruitsrabbit	lightmyway	f	かめりあ feat. STΔRLIVHT
67	Lumia	BYD	9	9.5	814	180	2:03	3.2	Toaster.	mins	lumia	t	sky_delta
69	Dement ~after legend~	PRS	6	6	756	210	2:09	1.0	Toaster	\N	dement	f	Cosmograph
70	Dement ~after legend~	FTR	7+	7.8	970	210	2:09	1.0	Toaster	\N	dement	f	Cosmograph
1160	LIVHT MY WΔY	PRS	7	7.5	738	190	2:01	5.2	k//eternal + nitro\n"recursive present"	fruitsrabbit	lightmyway	f	かめりあ feat. STΔRLIVHT
1161	LIVHT MY WΔY	FTR	9+	9.8	954	190	2:01	5.2	k//eternal + nitro\n"convergent future"	fruitsrabbit	lightmyway	f	かめりあ feat. STΔRLIVHT
1162	Hotarubi no Yuki	PST	3	3.5	589	159	2:40	5.2	0°Nitro	Bison	hotarubinoyuki	f	Endorfin.
1163	Hotarubi no Yuki	PRS	7	7	733	159	2:40	5.2	0°Nitro	Bison	hotarubinoyuki	f	Endorfin.
1164	Hotarubi no Yuki	FTR	9+	9.7	991	159	2:40	5.2	0°Nitro	Bison	hotarubinoyuki	f	Endorfin.
1165	The Formula	PST	3	3	427	144	2:23	5.3	Dec18	鑓田 (alpha complex)	theformula	f	Junk
1166	The Formula	PRS	6	6	587	144	2:23	5.3	Dec18	鑓田 (alpha complex)	theformula	f	Junk
1167	The Formula	FTR	9	9.3	957	144	2:23	5.3	Dec18	鑓田 (alpha complex)	theformula	f	Junk
1168	Luna Rossa	PST	3	3	443	174	1:59	5.3	Luxance	未早	lunarossa	f	r0y
1169	Luna Rossa	PRS	6	6	578	174	1:59	5.3	Luxance	未早	lunarossa	f	r0y
1170	Luna Rossa	FTR	9+	9.7	920	174	1:59	5.3	Luxance	未早	lunarossa	f	r0y
1171	Jingle	PST	2	2.5	530	170	2:47	5.4	Exschwasion	黒兎 + Hitomasu Modoru	jingle	f	DJ Noriken
1172	Jingle	PRS	5	5.5	741	170	2:47	5.4	Exschwasion	黒兎 + Hitomasu Modoru	jingle	f	DJ Noriken
1173	Jingle	FTR	7+	7.8	848	170	2:47	5.4	Exschwasion	黒兎 + Hitomasu Modoru	jingle	f	DJ Noriken
1174	Jingle	ETR	9	9.5	1047	170	2:47	5.4	KLMNOP	黒兎 + Hitomasu Modoru	jingle	f	DJ Noriken
1175	Innocence	PST	3	3	734	190	2:37	5.4	First Dawn	すずなし	innocence	f	Powerless feat. Sennzai
1176	Innocence	PRS	6	6.5	811	190	2:37	5.4	First Dawn	すずなし	innocence	f	Powerless feat. Sennzai
1177	Innocence	FTR	8	8.5	1023	190	2:37	5.4	First Dawn	すずなし	innocence	f	Powerless feat. Sennzai
1178	Innocence	ETR	9+	9.7	1157	190	2:37	5.4	First Dawn	すずなし	innocence	f	Powerless feat. Sennzai
1179	IONOSTREAM	PST	3	3.5	845	220-254	2:12	5.4	Nitro	Cem, septem47	ionostream	f	Tatsh
1180	IONOSTREAM	PRS	6	6	890	220-254	2:12	5.4	Nitro	Cem, septem47	ionostream	f	Tatsh
1181	IONOSTREAM	FTR	8+	8.7	818	220-254	2:12	5.4	Dec18 + Nitro	Cem, septem47	ionostream	f	Tatsh
1182	IONOSTREAM	ETR	9+	9.7	871	220-254	2:12	5.4	Dec18 + Nitro	Cem, septem47	ionostream	f	Tatsh
1183	Aleph-0	PST	5	5.5	388	35-400	2:20	5.4	ə₀	Optie	alephzero	f	LeaF
1184	Aleph-0	PRS	8+	8.8	579	35-400	2:20	5.4	ə₀	Optie	alephzero	f	LeaF
1185	Aleph-0	FTR	10	10.5	919	35-400	2:20	5.4	ə₀	Optie	alephzero	f	LeaF
1186	Masquerade Legion	PST	3	3.5	510	175	2:25	5.4	Nitro 「The Veiled」	KEI	masqueradelegion	f	Srav3R & DJ Noriken
1187	Masquerade Legion	PRS	6	6.5	698	175	2:25	5.4	Nitro 「The Veiled」	KEI	masqueradelegion	f	Srav3R & DJ Noriken
1188	Masquerade Legion	FTR	10	10	1064	175	2:25	5.4	Nitro 「The Veiled」	KEI	masqueradelegion	f	Srav3R & DJ Noriken
1189	KYOREN ROMANCE	PST	4	4	821	205	2:40	5.4	Dec18 + Nitro	イカダ	kyorenromance	f	REDALiCE vs DJ Myosuke feat. DELUTAYA
1190	KYOREN ROMANCE	PRS	7+	7.8	982	205	2:40	5.4	Dec18 + Nitro	イカダ	kyorenromance	f	REDALiCE vs DJ Myosuke feat. DELUTAYA
1191	KYOREN ROMANCE	FTR	10+	10.7	1519	205	2:40	5.4	Dec18 + Nitro	イカダ	kyorenromance	f	REDALiCE vs DJ Myosuke feat. DELUTAYA
1192	Qovat	PST	4	4.5	519	122	2:41	5.4	ex＊tree	Watersnake	qovat	f	owl＊tree
1193	Qovat	PRS	8	8.2	765	122	2:41	5.4	ex＊tree	Watersnake	qovat	f	owl＊tree
1194	Qovat	FTR	10	10.4	1299	122	2:41	5.4	ny＊tree	Watersnake	qovat	f	owl＊tree
1195	HELLOHELL	PST	2	2.5	466	155	2:20	5.5	én	原之	hellohell	f	暁Records
1196	HELLOHELL	PRS	5	5	445	155	2:20	5.5	én	原之	hellohell	f	暁Records
1197	HELLOHELL	FTR	7	7.5	673	155	2:20	5.5	én	原之	hellohell	f	暁Records
1198	HELLOHELL	ETR	9	9.3	770	155	2:20	5.5	eién	原之	hellohell	f	暁Records
1199	〇、	PST	2	2.5	368	145	2:17	5.5	CERiNG、	毛腿猪兔子 & Kolaa	ichirin	f	Kolaa & 熊子
1200	〇、	PRS	6	6.5	519	145	2:17	5.5	CERiNG、	毛腿猪兔子 & Kolaa	ichirin	f	Kolaa & 熊子
1201	〇、	FTR	9	9.5	708	145	2:17	5.5	CERiNG、	毛腿猪兔子 & Kolaa	ichirin	f	Kolaa & 熊子
1202	Awaken In Ruins	PST	3	3.5	412	125	2:16	5.5	antymis	人間蛋	awakeninruins	f	Supa7onyz
1203	Awaken In Ruins	PRS	7	7.5	570	125	2:16	5.5	antymis	人間蛋	awakeninruins	f	Supa7onyz
1204	Awaken In Ruins	FTR	9+	9.7	754	125	2:16	5.5	antymis	人間蛋	awakeninruins	f	Supa7onyz
1205	MORNINGLOOM	PST	3	3	710	102	2:20	5.5	Exschwasion • 8:00	すずあ	morningloom	f	saaa
1206	MORNINGLOOM	PRS	6	6.5	829	102	2:20	5.5	Exschwasion • 8:21	すずあ	morningloom	f	saaa
1207	MORNINGLOOM	FTR	8+	8.8	940	102	2:20	5.5	Exschwasion • 8:45	すずあ	morningloom	f	saaa
1208	MORNINGLOOM	ETR	9+	9.8	1035	102	2:20	5.5	Exschwasion • 8:46	すずあ	morningloom	f	saaa
1209	Lethal Voltage	PST	4	4.5	724	190	2:41	5.5	moonquay [EMP]	mochi’s pizza	lethalvoltage	f	siqlo
1210	Lethal Voltage	PRS	7+	7.8	922	190	2:41	5.5	moonquay [FLASH]	mochi’s pizza	lethalvoltage	f	siqlo
71	Dement ~after legend~	BYD	9+	9.9	1040	210	2:09	3.1	Nitro ~ABYSS~	\N	dement	t	Cosmograph
72	Dandelion	PST	2	2.5	391	169	2:38	1.0	Nitro	\N	dandelion	f	Farhan
73	Dandelion	PRS	6	6	698	169	2:38	1.0	Nitro	\N	dandelion	f	Farhan
74	Dandelion	FTR	8	8.5	921	169	2:38	1.0	Nitro	\N	dandelion	f	Farhan
1211	Lethal Voltage	FTR	10	10.4	1497	190	2:41	5.5	moonquay [SHOCK]	mochi’s pizza	lethalvoltage	f	siqlo
1212	MIRINAE	PST	4	4.5	646	180	2:38	5.5	N↑TRO	すずなし	mirinae	f	TAK × Zekk
1213	MIRINAE	PRS	8	8.3	881	180	2:38	5.5	N↑TRO	すずなし	mirinae	f	TAK × Zekk
1214	MIRINAE	FTR	10	10.4	1277	180	2:38	5.5	N↑TRO	すずなし	mirinae	f	TAK × Zekk
1215	ultradiaxon-N3	PST	4	4.5	605	150	2:38	5.5	Nitro	MiyU	ultradiaxon	f	nitro (lowiro)
1216	ultradiaxon-N3	PRS	8	8.5	896	150	2:38	5.5	Nitro	MiyU	ultradiaxon	f	nitro (lowiro)
1217	ultradiaxon-N3	FTR	10	10.3	1228	150	2:38	5.5	Nitro	MiyU	ultradiaxon	f	nitro (lowiro)
1218	Leave All Behind	PST	2	2	380	150	2:07	5.6	Luxance	NoteRE	leaveallbehind	f	rider
1219	Leave All Behind	PRS	5	5.5	488	150	2:07	5.6	Luxance	NoteRE	leaveallbehind	f	rider
1220	Leave All Behind	FTR	9	9.2	828	150	2:07	5.6	Luxance	NoteRE	leaveallbehind	f	rider
1221	Distorted Fate	PST	4	4.5	756	150	2:41	5.6	Toaster	knife美工刀	distortedfate	f	Sakuzyo
1222	Distorted Fate	PRS	7+	7.8	890	150	2:41	5.6	Toaster	knife美工刀	distortedfate	f	Sakuzyo
1223	Distorted Fate	FTR	9	9.6	1172	150	2:41	5.6	Toaster	knife美工刀	distortedfate	f	Sakuzyo
1224	Distorted Fate	ETR	10+	10.8	1402	150	2:41	5.6	TOASTER DATA PATCHER	knife美工刀	distortedfate	f	Sakuzyo
1225	Floating World	PST	3	3	753	174	2:37	5.6	én	チェリ藻	floatingworld	f	baker feat. botan
1226	Floating World	PRS	7	7	793	174	2:37	5.6	én	チェリ藻	floatingworld	f	baker feat. botan
1227	Floating World	FTR	9	9.3	1047	174	2:37	5.6	én	チェリ藻	floatingworld	f	baker feat. botan
1228	Chromafill	PST	4	4	757	179	2:32	5.6	exschwasion -彩色-	イチゼンリュウ	chromafill	f	ていぬ
1229	Chromafill	PRS	7	7	890	179	2:32	5.6	exschwasion -彩色-	イチゼンリュウ	chromafill	f	ていぬ
1230	Chromafill	FTR	10	10	1130	179	2:32	5.6	exschwasion -彩色-	イチゼンリュウ	chromafill	f	ていぬ
1231	Désive	PST	5	5	1007	180-230	2:46	5.6	Yearning Call	そゐち	desive	f	MisomyL
1232	Désive	PRS	8	8	1051	180-230	2:46	5.6	Yearning Call	そゐち	desive	f	MisomyL
1233	Désive	FTR	9+	9.9	1273	180-230	2:46	5.6	Yearning Call	そゐち	desive	f	MisomyL
1234	Désive	ETR	10+	10.8	1340	180-230	2:46	5.6	Yearning Call	そゐち	desive	f	MisomyL
1235	Hidden Rainbows of Epicurus	PST	2	2.5	595	155	2:24	5.7	Dec18	ののこ	epicurus	f	SYNC.ART'S feat.Misato
1236	Hidden Rainbows of Epicurus	PRS	5	5.5	644	155	2:24	5.7	Dec18	ののこ	epicurus	f	SYNC.ART'S feat.Misato
1237	Hidden Rainbows of Epicurus	FTR	7	7.5	783	155	2:24	5.7	Dec18	ののこ	epicurus	f	SYNC.ART'S feat.Misato
1238	Hidden Rainbows of Epicurus	ETR	8+	8.8	884	155	2:24	5.7	Dec18	ののこ	epicurus	f	SYNC.ART'S feat.Misato
1239	Twilight Concerto	PST	4	4.5	584	194	1:50	5.7	Exschwasion	\N	tasogare	f	Scarlette
1240	Twilight Concerto	PRS	7+	7.8	634	194	1:50	5.7	Exschwasion	\N	tasogare	f	Scarlette
1241	Twilight Concerto	FTR	9	9.5	803	194	1:50	5.7	Exschwasion	\N	tasogare	f	Scarlette
1242	Twilight Concerto	ETR	10	10.5	962	194	1:50	5.7	Exschwasion	\N	tasogare	f	Scarlette
1243	Old School Salvage	PST	4	4	705	205	2:46	5.7	antymis	tvchany	oldschoolsalvage	f	DJ SHARPNEL
1244	Old School Salvage	PRS	7+	7.8	950	205	2:46	5.7	antymis	tvchany	oldschoolsalvage	f	DJ SHARPNEL
1245	Old School Salvage	FTR	9+	9.8	1316	205	2:46	5.7	antymis + Nitro	tvchany	oldschoolsalvage	f	DJ SHARPNEL
1246	Beautiful Dreamer	PST	4	4	611	188	2:21	5.7	CERiNG	さんぱち	beautifuldreamer	f	M-Project
1247	Beautiful Dreamer	PRS	7+	7.8	773	188	2:21	5.7	CERiNG	さんぱち	beautifuldreamer	f	M-Project
1248	Beautiful Dreamer	FTR	9+	9.9	1139	188	2:21	5.7	CERiNG	さんぱち	beautifuldreamer	f	M-Project
1249	Back to Basics	PST	5	5	717	420	2:35	5.7	夜浪 THE FUMEn ANARCHIST	TKKsn.	backtobasics	f	m1dy
1250	Back to Basics	PRS	8+	8.7	1115	420	2:35	5.7	夜浪 THE FUMEn ANARCHIST	TKKsn.	backtobasics	f	m1dy
1251	Back to Basics	FTR	10	10.6	1544	420	2:35	5.7	夜浪 THE FUMEn ANARCHIST	TKKsn.	backtobasics	f	m1dy
1252	STARGATE EXTREME	PST	4	4	337	150	2:01	5.8	én	SARYN	stargateextreme	f	KARUT
1253	STARGATE EXTREME	PRS	6	6	430	150	2:01	5.8	én	SARYN	stargateextreme	f	KARUT
1254	STARGATE EXTREME	FTR	9	9.3	724	150	2:01	5.8	én	SARYN	stargateextreme	f	KARUT
1255	STARGATE EXTREME	ETR	9+	9.9	915	150	2:01	5.8	eién	SARYN	stargateextreme	f	KARUT
1256	Sign of "10.5km"	PST	3	3	490	160	2:14	5.8	Dec18	\N	signof	f	渡部恭久
1257	Sign of "10.5km"	PRS	6	6.5	564	160	2:14	5.8	Dec18	\N	signof	f	渡部恭久
1258	Sign of "10.5km"	FTR	9	9.2	735	160	2:14	5.8	Dec18	\N	signof	f	渡部恭久
1259	10pt8ion	PST	4	4	475	128-185	2:09	5.8	Nitro	\N	temptationgc	f	Lite Show Magic
1260	10pt8ion	PRS	7+	7.8	704	128-185	2:09	5.8	Nitro	\N	temptationgc	f	Lite Show Magic
75	Anökumene	PST	2	2.5	412	186	1:56	1.0	Toaster	Khronetic	anokumene	f	Jun Kuroda
76	Anökumene	PRS	6	6.5	588	186	1:56	1.0	Toaster	Khronetic	anokumene	f	Jun Kuroda
77	Anökumene	FTR	9	9.2	851	186	1:56	1.0	Toaster	Khronetic	anokumene	f	Jun Kuroda
1261	10pt8ion	FTR	9+	9.8	906	128-185	2:09	5.8	Nite Schwa Power	\N	temptationgc	f	Lite Show Magic
1262	10pt8ion	ETR	10	10.5	1087	128-185	2:09	5.8	Nite Schwa Power	\N	temptationgc	f	Lite Show Magic
1263	Black MInD	PST	5	5	601	192	2:13	5.8	聖輪	\N	blackmind	f	COSIO
1264	Black MInD	PRS	8	8	754	192	2:13	5.8	聖輪	\N	blackmind	f	COSIO
1265	Black MInD	FTR	10+	10.8	1274	192	2:13	5.8	聖輪	\N	blackmind	f	COSIO
1266	HYPER VISION	PST	4	4.5	639	155	2:38	5.8	NITRO	洗濯メン	hypervision	f	VOLTA
1267	HYPER VISION	PRS	7	7.5	839	155	2:38	5.8	NITRO	洗濯メン	hypervision	f	VOLTA
1268	HYPER VISION	FTR	9+	9.8	1040	155	2:38	5.8	NITRO	洗濯メン	hypervision	f	VOLTA
1269	Distortion Human	PST	3	3	544	200	2:29	5.9	ディストーション・ルクアンス	\N	distortionhuman	f	DJ Myosuke & KAJI
1270	Distortion Human	PRS	6	6.5	841	200	2:29	5.9	ディストーション・ルクアンス	\N	distortionhuman	f	DJ Myosuke & KAJI
1271	Distortion Human	FTR	9+	9.9	1317	200	2:29	5.9	ディストーション・ルクアンス	\N	distortionhuman	f	DJ Myosuke & KAJI
1272	shrink	PST	3	3.5	451	180	2:02	5.9	Dec18	\N	shrink	f	Shohei Tsuchiya(ZUNTATA)
1273	shrink	PRS	7	7	660	180	2:02	5.9	Dec18	\N	shrink	f	Shohei Tsuchiya(ZUNTATA)
1275	In Vain	PST	3	3.5	562	165	2:33	5.9	CERiNG	トロ３	invain	f	ryhki
1276	In Vain	PRS	6	6.5	677	165	2:33	5.9	CERiNG	トロ３	invain	f	ryhki
1277	In Vain	FTR	9	9.5	1111	165	2:33	5.9	CERiNG	トロ３	invain	f	ryhki
1278	Hypnotize	PST	3	3.5	518	160	2:33	5.9	én	つくだ煮	hypnotize	f	rejection
1279	Hypnotize	PRS	7	7	761	160	2:33	5.9	én	つくだ煮	hypnotize	f	rejection
1280	Hypnotize	FTR	8+	8.9	993	160	2:33	5.9	én	つくだ煮	hypnotize	f	rejection
1281	Hypnotize	ETR	9+	9.9	1164	160	2:33	5.9	én × nitro「The Radical」	つくだ煮	hypnotize	f	rejection
1282	Ashen 6oundary	PST	4	4.5	702	172	2:28	5.9	[NITRO]	AT基調	ashenboundary	f	YUKIYANAGI
1283	Ashen 6oundary	PRS	7+	7.8	813	172	2:28	5.9	[NITRO]	AT基調	ashenboundary	f	YUKIYANAGI
1284	Ashen 6oundary	FTR	9+	9.9	1183	172	2:28	5.9	[NITRO]	AT基調	ashenboundary	f	YUKIYANAGI
1285	Judgement	PST	5	5.5	844	200	2:52	5.9	絶滅 » collapse	辷	judgement	f	Tatsunoshin
1286	Judgement	PRS	8	8.6	1055	200	2:52	5.9	絶滅 » collapse	辷	judgement	f	Tatsunoshin
1287	Judgement	FTR	10	10.5	1432	200	2:52	5.9	絶滅 » collapse	辷	judgement	f	Tatsunoshin
1288	ALTER EGO	PST	6	6.5	865	195	2:40	5.9	Article V《Observation》	すずなし	alterego	f	Yuta Imai vs Qlarabelle
1289	ALTER EGO	PRS	9	9.2	1213	195	2:40	5.9	Article VI《Hypothesis》	すずなし	alterego	f	Yuta Imai vs Qlarabelle
1290	ALTER EGO	FTR	10	10.5	1466	195	2:40	5.9	Article VII《Analysis》	すずなし	alterego	f	Yuta Imai vs Qlarabelle
1291	ALTER EGO	ETR	11	11.3	1644	195	2:40	5.9	Article 0x8《Enmity》	すずなし	alterego	f	Yuta Imai vs Qlarabelle
1292	epitaxy	PST	3	3	826	183	2:49	5.10	Dec18	唯莎	epitaxy	f	Camellia
1293	epitaxy	PRS	6	6	939	183	2:49	5.10	Dec18	唯莎	epitaxy	f	Camellia
1294	epitaxy	FTR	8	8.6	1177	183	2:49	5.10	Dec18	唯莎	epitaxy	f	Camellia
1295	epitaxy	ETR	9	9.6	1410	183	2:49	5.10	Dec18	唯莎	epitaxy	f	Camellia
1296	Waltz for Lorelei	PST	2	2.5	664	220	2:11	5.10	antymis	夕西	waltzforlorelei	f	Sobrem & 庭師
1297	Waltz for Lorelei	PRS	5	5.5	814	220	2:11	5.10	antymis	夕西	waltzforlorelei	f	Sobrem & 庭師
1298	Waltz for Lorelei	FTR	8+	8.8	916	220	2:11	5.10	antymis	夕西	waltzforlorelei	f	Sobrem & 庭師
1299	Waltz for Lorelei	ETR	9+	9.8	999	220	2:11	5.10	antymis	夕西	waltzforlorelei	f	Sobrem & 庭師
1300	Dual Doom Deathmatch	PST	3	3.5	838	222	2:21	5.10	NITRO	炎獵	dualdoom	f	Kobaryo vs HyuN
1301	Dual Doom Deathmatch	PRS	6	6.5	830	222	2:21	5.10	NITRO	炎獵	dualdoom	f	Kobaryo vs HyuN
1302	Dual Doom Deathmatch	FTR	8+	8.9	1094	222	2:21	5.10	NITRO	炎獵	dualdoom	f	Kobaryo vs HyuN
1303	Dual Doom Deathmatch	ETR	10	10.3	1292	222	2:21	5.10	NITRO	炎獵	dualdoom	f	Kobaryo vs HyuN
1304	Inverted World	PST	3	3	525	180	2:13	5.10	↑én↓	Mechari	invertedworld	f	ARForest
1305	Inverted World	PRS	7	7	646	180	2:13	5.10	↑én↓	Mechari	invertedworld	f	ARForest
1306	Inverted World	FTR	9	9.5	940	180	2:13	5.10	↑én↓	Mechari	invertedworld	f	ARForest
1307	Inverted World	ETR	10+	10.7	1065	180	2:13	5.10	聖輪↓↑夜浪	Mechari	invertedworld	f	ARForest
1308	MVURBD	PST	4	4.5	999	175	2:50	5.10	絶滅	noel	mvurbd	f	ETIA.
1309	MVURBD	PRS	7+	7.8	1031	175	2:50	5.10	絶滅	noel	mvurbd	f	ETIA.
1310	MVURBD	FTR	10	10.6	1497	175	2:50	5.10	絶滅	noel	mvurbd	f	ETIA.
1311	Vulcānus	PST	5	5.5	968	212	2:43	5.10	Volution	月裏	vulcanus	f	Team Grimoire vs Aoi
1312	Vulcānus	PRS	8	8.5	1234	212	2:43	5.10	Volution CCCLX	月裏	vulcanus	f	Team Grimoire vs Aoi
1313	Vulcānus	FTR	10+	10.9	1542	212	2:43	5.10	Volution IV	月裏	vulcanus	f	Team Grimoire vs Aoi
78	Anökumene	BYD	9+	9.9	971	186	1:56	6.4	Astral Luxance	Khronetic	anokumene	f	Jun Kuroda
79	Infinity Heaven	PST	1	1.5	336	160	2:34	1.0	Nitro	Tagtraume	infinityheaven	f	HyuN
80	Infinity Heaven	PRS	5	5.5	545	160	2:34	1.0	Nitro	Tagtraume	infinityheaven	f	HyuN
1314	Rain of Conflict in a Radiant Abyss	PST	5	5	831	195	2:30	5.10	Nitro “v20170309”	辷	rainofconflict	f	ak+q
1315	Rain of Conflict in a Radiant Abyss	PRS	7+	7.8	934	195	2:30	5.10	Nitro “v20170309”	辷	rainofconflict	f	ak+q
1316	Rain of Conflict in a Radiant Abyss	FTR	9	9.5	1164	195	2:30	5.10	Nitro “v20170309”	辷	rainofconflict	f	ak+q
1317	Rain of Conflict in a Radiant Abyss	ETR	10	10.5	1247	195	2:30	5.10	Nitro meets Toaster “v20170309”	辷	rainofconflict	f	ak+q
1318	Saint or Sinner	PST	3	3	447	164	2:27	5.10	小終点	yawa	saintorsinner	f	crayvxn
1319	Saint or Sinner	PRS	6	6	563	164	2:27	5.10	小終点	yawa	saintorsinner	f	crayvxn
1320	Saint or Sinner	FTR	8+	8.8	906	164	2:27	5.10	小終点	yawa	saintorsinner	f	crayvxn
1321	Saint or Sinner	BYD	10	10.4	1124	164	2:27	6.13	↑零下↑	yawa	saintorsinner	t	crayvxn
1322	Hailstone	PST	3	3.5	534	180	2:09	5.10	raycast	mogami	hailstone	f	Kazki Misora
1323	Hailstone	PRS	7	7	651	180	2:09	5.10	raycast	mogami	hailstone	f	Kazki Misora
1324	Hailstone	FTR	9+	9.7	1002	180	2:09	5.10	raycast	mogami	hailstone	f	Kazki Misora
1325	FURETE-MITAI	PST	2	2.5	447	155	2:01	5.10	nora::neko	\N	furetemitai	f	みきとP
1326	FURETE-MITAI	PRS	6	6	523	155	2:01	5.10	nora::neko	\N	furetemitai	f	みきとP
1327	FURETE-MITAI	FTR	8	8.4	763	155	2:01	5.10	nora::neko	\N	furetemitai	f	みきとP
1328	FURETE-MITAI	ETR	9	9.4	841	155	2:01	5.10	nora::neko	\N	furetemitai	f	みきとP
1329	Gensou no Satellite	PST	2	2.5	721	230	2:32	5.10	Luxance	ランコの姉 (豚乙女)	gensounosatellite	f	豚乙女
1330	Gensou no Satellite	PRS	6	6.5	783	230	2:32	5.10	Luxance	ランコの姉 (豚乙女)	gensounosatellite	f	豚乙女
1331	Gensou no Satellite	FTR	8+	8.7	992	230	2:32	5.10	Luxance	ランコの姉 (豚乙女)	gensounosatellite	f	豚乙女
1332	Gensou no Satellite	ETR	10	10.1	1139	230	2:32	5.10	Luxance	ランコの姉 (豚乙女)	gensounosatellite	f	豚乙女
1333	Prayer	PST	2	2.5	419	132	2:31	5.10	nora::neko	自動車 原付&なぎのにちこ	prayer	f	qfeileadh&レゾナンスもえこ
1334	Prayer	PRS	5	5.5	479	132	2:31	5.10	nora::neko	自動車 原付&なぎのにちこ	prayer	f	qfeileadh&レゾナンスもえこ
1335	Prayer	FTR	8	8.2	591	132	2:31	5.10	nora::neko	自動車 原付&なぎのにちこ	prayer	f	qfeileadh&レゾナンスもえこ
1336	Prayer	ETR	9	9.1	714	132	2:31	5.10	nora::neko	自動車 原付&なぎのにちこ	prayer	f	qfeileadh&レゾナンスもえこ
1337	Crimson Quartz	PST	3	3	569	145	2:43	5.10	raycast	雨音くるみ	crimsonquartz	f	DiGiTAL WiNG with 空音
1338	Crimson Quartz	PRS	6	6	615	145	2:43	5.10	raycast	雨音くるみ	crimsonquartz	f	DiGiTAL WiNG with 空音
1339	Crimson Quartz	FTR	8+	8.8	861	145	2:43	5.10	raycast	雨音くるみ	crimsonquartz	f	DiGiTAL WiNG with 空音
1340	Crimson Quartz	ETR	9+	9.8	1200	145	2:43	5.10	raycast	雨音くるみ	crimsonquartz	f	DiGiTAL WiNG with 空音
1341	Third Sun	PST	3	3.5	532	75-225	2:38	5.10	NEO NITRO	Ash Astral	thirdsun	f	Ash Astral
1342	Third Sun	PRS	7	7	702	75-225	2:38	5.10	NEO NITRO	Ash Astral	thirdsun	f	Ash Astral
1343	Third Sun	FTR	9	9.4	811	75-225	2:38	5.10	NEO NITRO	Ash Astral	thirdsun	f	Ash Astral
1344	Third Sun	ETR	10	10	1043	75-225	2:38	5.10	NEO NITRO	Ash Astral	thirdsun	f	Ash Astral
1345	Spirit of the Dauntless	PST	4	4.5	693	180	2:29	5.10	絶滅	てるオ実	spiritdauntless	f	KO3 & Relect
1346	Spirit of the Dauntless	PRS	7+	7.8	957	180	2:29	5.10	絶滅	てるオ実	spiritdauntless	f	KO3 & Relect
1347	Spirit of the Dauntless	FTR	10	10.5	1207	180	2:29	5.10	絶滅	てるオ実	spiritdauntless	f	KO3 & Relect
1348	Dies irae	PST	4	4.5	632	172	2:32	5.10	M理論	michele	diesirae	f	お月さま交響曲
1349	Dies irae	PRS	7	7.5	802	172	2:32	5.10	M理論	michele	diesirae	f	お月さま交響曲
1350	Dies irae	FTR	9	9.5	1052	172	2:32	5.10	M理論	michele	diesirae	f	お月さま交響曲
1351	Dies irae	ETR	10	10.6	1263	172	2:32	5.10	M理論	michele	diesirae	f	お月さま交響曲
1352	astral.exe	PST	3	3	654	174	2:35	6.0	antymis.exe	kkmfd	astralexe	f	Synzak & Laxeno57
1353	astral.exe	PRS	6	6	734	174	2:35	6.0	antymis.exe	kkmfd	astralexe	f	Synzak & Laxeno57
1354	astral.exe	FTR	9	9.5	1059	174	2:35	6.0	antymis.exe	kkmfd	astralexe	f	Synzak & Laxeno57
1355	LiftOff	PST	3	3	459	137	2:15	6.0	Luxance's Case-Book	\N	liftoff	f	MAYA AKAI
1356	LiftOff	PRS	6	6.5	500	137	2:15	6.0	Luxance's Case-Book	\N	liftoff	f	MAYA AKAI
1357	LiftOff	FTR	8	8.2	660	137	2:15	6.0	Luxance's Case-Book	\N	liftoff	f	MAYA AKAI
1358	LiftOff	ETR	9+	9.8	988	137	2:15	6.0	Luxance's Case-Book	\N	liftoff	f	MAYA AKAI
1359	SUPER AMBULANCE	PST	4	4.5	740	200	2:31	6.0	moonquay【新入生】	\N	superambulance	f	AJURIKA
1360	SUPER AMBULANCE	PRS	7	7.5	971	200	2:31	6.0	moonquay v.EXPERT	\N	superambulance	f	AJURIKA
1361	SUPER AMBULANCE	FTR	10	10.3	1371	200	2:31	6.0	moonquay v.MASTER	\N	superambulance	f	AJURIKA
1362	Don't Fight The Music	PST	4	4.5	757	190-200	2:39	6.0	絶滅 (AQUA) Lv.70	\N	dontfightmusic	f	黒魔
81	Infinity Heaven	FTR	7+	7.8	853	160	2:34	1.0	Nitro	Tagtraume	infinityheaven	f	HyuN
82	Infinity Heaven	BYD	9	9.6	986	160	2:34	3.0	Nitr∞	Tagtraume	infinityheaven	t	HyuN
83	Party Vinyl	PST	4	4	337	132	1:50	1.0	Party Toaster	アサヤ	partyvinyl	f	モリモリあつし
1363	Don't Fight The Music	PRS	7+	7.8	962	190-200	2:39	6.0	絶滅 (AQUA) Lv.70	\N	dontfightmusic	f	黒魔
1364	Don't Fight The Music	FTR	9	9.3	1043	190-200	2:39	6.0	絶滅 (AQUA) Lv.70	\N	dontfightmusic	f	黒魔
1365	Don't Fight The Music	ETR	10+	10.7	1385	190-200	2:39	6.0	絶滅 (AQUA) Lv.70	\N	dontfightmusic	f	黒魔
1366	And Revive The Melody	PST	5	5.5	962	210-220	2:49	6.0	夜浪 (FIRE) Lv.75	\N	andrevivemelody	f	黒魔
1367	And Revive The Melody	PRS	8	8.5	1269	210-220	2:49	6.0	夜浪 (FIRE) Lv.75	\N	andrevivemelody	f	黒魔
1368	And Revive The Melody	FTR	10+	10.9	1710	210-220	2:49	6.0	夜浪 (FIRE) Lv.75	\N	andrevivemelody	f	黒魔
1369	Swan Song	PST	3	3	563	148	2:42	6.0	小終点	Noyu	swansong	f	void (Mournfinale)
1370	Swan Song	PRS	7	7.5	719	148	2:42	6.0	小終点	Noyu	swansong	f	void (Mournfinale)
1371	Swan Song	FTR	9+	9.9	1225	148	2:42	6.0	小終点	Noyu	swansong	f	void (Mournfinale)
1372	Renegade	PST	4	4.5	655	186	2:25	6.0	raycast, The Devout	辷	renegade	f	sky_delta
1373	Renegade	PRS	7+	7.8	751	186	2:25	6.0	raycast, The Devout	辷	renegade	f	sky_delta
1374	Renegade	FTR	9	9.6	994	186	2:25	6.0	raycast, The Devout	辷	renegade	f	sky_delta
1375	Renegade	BYD	10	10.2	1165	186	2:25	6.0	raycast, The Irresolute	辷	renegade	f	sky_delta
1376	Rays of Remnant	PST	4	4.5	710	200	2:11	6.0	nora::nue	はむメロン	raysofremnant	f	May × Felysrator
1377	Rays of Remnant	PRS	7	7.5	766	200	2:11	6.0	nora::nue	はむメロン	raysofremnant	f	May × Felysrator
1378	Rays of Remnant	FTR	9+	9.7	982	200	2:11	6.0	nora::nue	はむメロン	raysofremnant	f	May × Felysrator
1379	Rays of Remnant	BYD	10	10.4	1118	200	2:11	6.0	nora::nue	はむメロン	raysofremnant	f	May × Felysrator
1380	Breach of Faith	PST	5	5.5	986	172	2:38	6.0	夜浪「perfidulo」	おにねこ	breachoffaith	f	Supire feat.eili
1381	Breach of Faith	PRS	8	8.4	1171	172	2:38	6.0	夜浪「perfidulo」	おにねこ	breachoffaith	f	Supire feat.eili
1382	Breach of Faith	FTR	10	10.3	1373	172	2:38	6.0	夜浪「perfidulo」	おにねこ	breachoffaith	f	Supire feat.eili
1383	Breach of Faith	BYD	10+	10.9	1448	172	2:38	6.0	夜浪「perfidulo」	おにねこ	breachoffaith	f	Supire feat.eili
1384	Lament Rain	PST	6	6.5	1025	200	2:45	6.0	⇆ Fixation	ああもんど	lamentrain	f	Ashrount vs. 打打だいず
1385	Lament Rain	PRS	8+	8.8	1186	200	2:45	6.0	⇆ Sublimation	ああもんど	lamentrain	f	Ashrount vs. 打打だいず
1386	Lament Rain	FTR	10	10.6	1380	200	2:45	6.0	⇆ Separation	ああもんど	lamentrain	f	Ashrount vs. 打打だいず
1387	Lament Rain	BYD	11	11.4	1637	200	2:45	6.0	⇆ Projection	ああもんど	lamentrain	f	Ashrount vs. 打打だいず
1388	Designant.	PST	7	7.5	1055	200	2:58	6.0	1st Command ≒ Legacy	すずなし	designant	f	Designant
1389	Designant.	PRS	9	9.6	1426	200	2:58	6.0	2nd Command ≒ Perfection	すずなし	designant	f	Designant
1390	Designant.	FTR	10+	10.9	1768	200	2:58	6.0	3rd Command ≒ Ascendance	すずなし	designant	f	Designant
1391	Designant.	BYD	11+	11.9	2184	200	2:58	6.0	Final Command. Infinity	すずなし	designant	f	Designant
1392	Astral Quantization	PST	5	5	782	185	2:35	6.0	Ψ	Enji	astralquant	f	Dj Grimoire
1393	Astral Quantization	PRS	8	8.1	943	185	2:35	6.0	Ψ	Enji	astralquant	f	Dj Grimoire
1394	Astral Quantization	FTR	10	10.6	1388	185	2:35	6.0	Ψ	Enji	astralquant	f	Dj Grimoire
1395	Ignition	PST	3	3.5	578	160	2:16	6.1	るくあんす	\N	ignition	f	パソコン音楽クラブ
1396	Ignition	PRS	6	6	621	160	2:16	6.1	るくあんす	\N	ignition	f	パソコン音楽クラブ
1397	Ignition	FTR	9+	9.8	994	160	2:16	6.1	るくあんす	\N	ignition	f	パソコン音楽クラブ
1398	BlazinG AIR	PST	3	3.5	433	150	2:20	6.1	BlazinG ÉND	\N	blazingair	f	kanone
1399	BlazinG AIR	PRS	6	6.5	571	150	2:20	6.1	BlazinG ÉND	\N	blazingair	f	kanone
1400	BlazinG AIR	FTR	8+	8.9	757	150	2:20	6.1	BlazinG ÉND	\N	blazingair	f	kanone
1401	BlazinG AIR	ETR	10	10.1	1129	150	2:20	6.1	BlazinG ÉND	\N	blazingair	f	kanone
1402	8-EM	PST	4	4.5	557	168	2:28	6.1	Exschwasion	\N	eightem	f	Sampling Masters AYA
1403	8-EM	PRS	7+	7.8	847	168	2:28	6.1	Exschwasion	\N	eightem	f	Sampling Masters AYA
1404	8-EM	FTR	9	9.5	1081	168	2:28	6.1	Rave Gallery	\N	eightem	f	Sampling Masters AYA
1405	8-EM	ETR	10	10.3	1201	168	2:28	6.1	X-SCHWASION	\N	eightem	f	Sampling Masters AYA
1406	DA'AT -The First Seeker of Souls-	PST	5	5.5	921	222	2:42	6.1	夜浪 -Revolutions-	\N	daat	f	水野健治 VS 大国奏音
1407	DA'AT -The First Seeker of Souls-	PRS	8	8.4	1091	222	2:42	6.1	夜浪 -Revolutions-	\N	daat	f	水野健治 VS 大国奏音
1408	DA'AT -The First Seeker of Souls-	FTR	10+	10.9	1500	222	2:42	6.1	夜浪 -Revolutions-	\N	daat	f	水野健治 VS 大国奏音
1409	BREaK! BREaK! BREaK!	PST	3	3.5	472	165	2:28	6.2	écologie	\N	breakbreak	f	HiTECH NINJA vs Cranky
1410	BREaK! BREaK! BREaK!	PRS	6	6.5	614	165	2:28	6.2	écologie	\N	breakbreak	f	HiTECH NINJA vs Cranky
1411	BREaK! BREaK! BREaK!	FTR	8+	8.8	894	165	2:28	6.2	écologie	\N	breakbreak	f	HiTECH NINJA vs Cranky
84	Party Vinyl	PRS	7+	7.8	543	132	1:50	1.0	Party Toaster	アサヤ	partyvinyl	f	モリモリあつし
85	Party Vinyl	FTR	9	9.4	800	132	1:50	1.0	Party Toaster	アサヤ	partyvinyl	f	モリモリあつし
86	Party Vinyl	BYD	10	10.3	946	132	1:50	4.1	Party Exschwasion	アサヤ	partyvinyl	t	モリモリあつし
1412	BREaK! BREaK! BREaK!	ETR	10	10.3	1251	165	2:28	6.2	EXSCHWASiON vs 絶滅	\N	breakbreak	f	HiTECH NINJA vs Cranky
1413	Straight into the lights	PST	4	4	583	90	2:29	6.2	nora::kuma	\N	straightintolights	f	Cosmograph
1414	Straight into the lights	PRS	7	7.5	714	90	2:29	6.2	nora::kuma	\N	straightintolights	f	Cosmograph
1415	Straight into the lights	FTR	9	9.5	1226	90	2:29	6.2	nora::kuma	\N	straightintolights	f	Cosmograph
1416	Straight into the lights	ETR	10	10.5	1280	90	2:29	6.2	反水 × 夜浪	\N	straightintolights	f	Cosmograph
1417	ViRTUS	PST	5	5.5	877	225	2:24	6.2	NiTRO	\N	virtus	f	Hiro
1418	ViRTUS	PRS	8	8.6	1000	225	2:24	6.2	NiTRO	\N	virtus	f	Hiro
1419	ViRTUS	FTR	9+	9.9	1222	225	2:24	6.2	NiTRO	\N	virtus	f	Hiro
1420	ViRTUS	ETR	10+	10.9	1341	225	2:24	6.2	NiTRO	\N	virtus	f	Hiro
1421	yomibito_shirazu	PST	4	4.5	641	188	2:26	6.2	<!-- raycast -->	\N	yomibitoshirazu	f	Limonène (サノカモメ+月島春果)
1422	yomibito_shirazu	PRS	8	8	764	188	2:26	6.2	<!-- raycast -->	\N	yomibitoshirazu	f	Limonène (サノカモメ+月島春果)
1423	yomibito_shirazu	FTR	9+	9.8	1075	188	2:26	6.2	<!-- raycast -->	\N	yomibitoshirazu	f	Limonène (サノカモメ+月島春果)
1424	Aether Crest: Astral	PST	6	6	921	180	2:44	6.2	Nitro	すずなし	aethercrest	f	void (Mournfinale) × 水野健治
1425	Aether Crest: Astral	PRS	8+	8.9	1147	180	2:44	6.2	Empyrean	すずなし	aethercrest	f	void (Mournfinale) × 水野健治
1426	Aether Crest: Astral	FTR	10	10.6	1508	180	2:44	6.2	M理論 《Quintessence》	すずなし	aethercrest	f	void (Mournfinale) × 水野健治
1427	Aether Crest: Astral	ETR	11	11.5	1941	180	2:44	6.2	夜浪 × 絶滅「αἴθων」	すずなし	aethercrest	f	void (Mournfinale) × 水野健治
1428	Heartache	PST	1	1.5	425	239	1:58	6.3	sidewaves	\N	heartache	f	Toby Fox
1429	Heartache	PRS	4	4.5	687	239	1:58	6.3	sidewaves	\N	heartache	f	Toby Fox
1430	Heartache	FTR	7	7.5	803	239	1:58	6.3	sidewaves	\N	heartache	f	Toby Fox
1431	Heartache	ETR	8+	8.7	851	239	1:58	6.3	sidewaves	\N	heartache	f	Toby Fox
1432	Death By Glamour	PST	2	2.5	460	148	2:17	6.3	RYCT QUIZ SHOW	\N	deathbyglamour	f	Toby Fox
1433	Death By Glamour	PRS	5	5	470	148	2:17	6.3	RYCT COOKING	\N	deathbyglamour	f	Toby Fox
1434	Death By Glamour	FTR	7+	7.8	610	148	2:17	6.3	RYCT NEWS	\N	deathbyglamour	f	Toby Fox
1435	Death By Glamour	ETR	9	9.4	912	148	2:17	6.3	RYCT THE MUSICAL	\N	deathbyglamour	f	Toby Fox
1436	Your Best Nightmare	PST	3	3.5	760	190	2:54	6.3	Nitro	\N	yourbestnightmare	f	Toby Fox
1437	Your Best Nightmare	PRS	6	6.5	925	190	2:54	6.3	Nitro	\N	yourbestnightmare	f	Toby Fox
1438	Your Best Nightmare	FTR	8+	8.9	1086	190	2:54	6.3	Arcaea Charting Team【The Six Souls】	\N	yourbestnightmare	f	Toby Fox
1439	Your Best Nightmare	BYD	10	10.2	1451	190	2:54	6.3	Arcaea Charting Team【The Six Souls】	\N	yourbestnightmare	f	Toby Fox
1440	Last Goodbye	PST	2	2.5	497	180	2:18	6.3	Luxance	\N	lastgoodbye	f	Toby Fox
1441	Last Goodbye	PRS	6	6.5	605	180	2:18	6.3	Luxance	\N	lastgoodbye	f	Toby Fox
1442	Last Goodbye	FTR	8	8.2	727	180	2:18	6.3	Luxance	\N	lastgoodbye	f	Toby Fox
1443	Last Goodbye	ETR	9+	9.7	911	180	2:18	6.3	Good night.	\N	lastgoodbye	f	Toby Fox
1444	MEGALOVANIA	PST	4	4.5	906	240	2:36	6.3	瑞獣 ＬＶ３	\N	megalovania	f	Toby Fox
1445	MEGALOVANIA	PRS	7	7.5	969	240	2:36	6.3	瑞獣 ＬＶ８	\N	megalovania	f	Toby Fox
1446	MEGALOVANIA	FTR	9	9.5	1064	240	2:36	6.3	瑞獣 ＬＶ１５	\N	megalovania	f	Toby Fox
1447	MEGALOVANIA	ETR	10	10.5	1202	240	2:36	6.3	瑞獣 ＬＶ１９	\N	megalovania	f	Toby Fox
1448	MEGALOVANIA (Camellia Remix)	PST	5	5.5	946	242	2:46	6.3	M理論	夏生	megalovaniarmx	f	Camellia
1449	MEGALOVANIA (Camellia Remix)	PRS	8	8.4	1161	242	2:46	6.3	M理論	夏生	megalovaniarmx	f	Camellia
1450	MEGALOVANIA (Camellia Remix)	FTR	9+	9.8	1345	242	2:46	6.3	M理論	夏生	megalovaniarmx	f	Camellia
1451	MEGALOVANIA (Camellia Remix)	ETR	10+	10.9	1468	242	2:46	6.3	* do you wanna have a bad time?	夏生	megalovaniarmx	f	Camellia
1452	Placebo♥Battler	PST	5	5.5	597	270	2:39	6.3	絶滅【再構築】	cyawa	placebobattler	f	OSTER project
1453	Placebo♥Battler	PRS	8	8.3	827	270	2:39	6.3	絶滅【再構築】	cyawa	placebobattler	f	OSTER project
1454	Placebo♥Battler	FTR	10	10.4	1194	270	2:39	6.3	絶滅【再構築】	cyawa	placebobattler	f	OSTER project
1455	Black Mirror on the Wall	PST	3	3.5	471	130	2:32	6.3	Nitro	原之	blackmirror	f	暁Records
1456	Black Mirror on the Wall	PRS	6	6.5	613	130	2:32	6.3	Nitro	原之	blackmirror	f	暁Records
1457	Black Mirror on the Wall	FTR	8	8.6	735	130	2:32	6.3	Nitro	原之	blackmirror	f	暁Records
1458	Black Mirror on the Wall	ETR	9+	9.7	894	130	2:32	6.3	KLMNOP	原之	blackmirror	f	暁Records
1459	Shinchoku Doudesuka?	PST	3	3.5	595	199	2:24	6.3	明日から頑張る	とろ美	shinchoku	f	sumijun feat. ななひら
1460	Shinchoku Doudesuka?	PRS	7	7.5	743	199	2:24	6.3	今からやります	とろ美	shinchoku	f	sumijun feat. ななひら
1	Sayonara Hatsukoi	PST	1	1.5	205	178	1:55	1.0	Nitro	\N	sayonarahatsukoi	f	REDSHiFT
87	Flashback	PST	2	2	356	195	2:02	1.0	Nitro	yoshimo	flashback	f	ARForest
1461	Shinchoku Doudesuka?	FTR	8+	8.8	957	199	2:24	6.3	もう少し待っててね	とろ美	shinchoku	f	sumijun feat. ななひら
1462	Shinchoku Doudesuka?	ETR	9+	9.9	1162	199	2:24	6.3	進捗ダメです	とろ美	shinchoku	f	sumijun feat. ななひら
1463	TRPNO	PST	4	4.5	451	150	2:05	6.3	raycast	BBBBB_old	trpno	f	Nauts
1464	TRPNO	PRS	7+	7.8	562	150	2:05	6.3	raycast	BBBBB_old	trpno	f	Nauts
1465	TRPNO	FTR	10	10	897	150	2:05	6.3	raycast	BBBBB_old	trpno	f	Nauts
1466	τ (tau)	PST	4	4.5	553	155	2:23	6.4	ə (exschwasion)	Square01	tau	f	Wooden
1467	τ (tau)	PRS	7+	7.8	798	155	2:23	6.4	ə (exschwasion)	Square01	tau	f	Wooden
1468	τ (tau)	FTR	9+	9.7	1057	155	2:23	6.4	ə (exschwasion)	Square01	tau	f	Wooden
1469	Dull Blade	PST	4	4.5	579	128-160	2:19	6.4	NITRO	kazari	dullblade	f	stuv
1470	Dull Blade	PRS	8	8	780	128-160	2:19	6.4	NITRO	kazari	dullblade	f	stuv
1471	Dull Blade	FTR	10	10.5	1199	128-160	2:19	6.4	NITRO	kazari	dullblade	f	stuv
1472	Won't Back Down	PST	3	3.5	437	165	2:13	6.5	én	\N	wontbackdown	f	Pure 100% / KASA
1473	Won't Back Down	PRS	6	6.5	551	165	2:13	6.5	én	\N	wontbackdown	f	Pure 100% / KASA
1474	Won't Back Down	FTR	9+	9.8	1015	165	2:13	6.5	én	\N	wontbackdown	f	Pure 100% / KASA
1475	Don't Die	PST	3	3.5	460	175	2:08	6.5	nora::neko	\N	dontdie	f	Paul Bazooka
1476	Don't Die	PRS	7	7	565	175	2:08	6.5	nora::neko	\N	dontdie	f	Paul Bazooka
1477	Don't Die	FTR	9	9.4	793	175	2:08	6.5	nora::neko	\N	dontdie	f	Paul Bazooka
1478	Don't Die	ETR	10	10.1	1004	175	2:08	6.5	nora::neko	\N	dontdie	f	Paul Bazooka
1479	Ladymade Star	PST	2	2.5	394	136	2:07	6.5	Nitro -FEVER-	\N	ladymadestar	f	ESTi
1480	Ladymade Star	PRS	6	6.5	491	136	2:07	6.5	Nitro -STAGE-	\N	ladymadestar	f	ESTi
1481	Ladymade Star	FTR	8	8.4	636	136	2:07	6.5	Nitro -PLATINUM-	\N	ladymadestar	f	ESTi
1482	Ladymade Star	ETR	9	9.2	753	136	2:07	6.5	Nitro -RESPECT-	\N	ladymadestar	f	ESTi
1483	End of The Moonlight	PST	3	3	340	155	1:53	6.5	sidewaves	\N	endmoonlight	f	Forte Escape
1484	End of The Moonlight	PRS	5	5.5	434	155	1:53	6.5	sidewaves	\N	endmoonlight	f	Forte Escape
1485	End of The Moonlight	FTR	9	9.5	738	155	1:53	6.5	sidewaves	\N	endmoonlight	f	Forte Escape
1486	U.A.D	PST	3	3.5	366	129	2:03	6.5	Exschwas⇅on	\N	uad	f	HAYAKO
1487	U.A.D	PRS	6	6.5	526	129	2:03	6.5	Exschwas⇅on	\N	uad	f	HAYAKO
1488	U.A.D	FTR	8+	8.7	643	129	2:03	6.5	Exschwas⇅on	\N	uad	f	HAYAKO
1489	U.A.D	ETR	9+	9.8	836	129	2:03	6.5	Exschwas⇅on	\N	uad	f	HAYAKO
1490	OBLIVION	PST	4	4	469	141	2:02	6.5	Toaster	\N	oblivion	f	ESTi
1491	OBLIVION	PRS	7	7	527	141	2:02	6.5	Toaster	\N	oblivion	f	ESTi
1492	OBLIVION	FTR	9	9.5	759	141	2:02	6.5	Toaster	\N	oblivion	f	ESTi
1493	OBLIVION	ETR	10	10.1	871	141	2:02	6.5	Toaster	\N	oblivion	f	ESTi
1494	Nightmare	PST	4	4.5	680	190	2:06	6.5	零下	\N	nightmare	f	M2U
1495	Nightmare	PRS	7+	7.8	757	190	2:06	6.5	零下	\N	nightmare	f	M2U
1496	Nightmare	FTR	9+	9.8	901	190	2:06	6.5	零下	\N	nightmare	f	M2U
1497	Nightmare	ETR	10+	10.8	1116	190	2:06	6.5	零下	\N	nightmare	f	M2U
1498	Tic! Tac! Toe!	PST	3	3.5	353	126	2:17	6.5	moonquay	\N	tictactoe	f	TAK x Corbin
1499	Tic! Tac! Toe!	PRS	7	7.5	505	126	2:17	6.5	moonquay	\N	tictactoe	f	TAK x Corbin
1500	Tic! Tac! Toe!	FTR	8+	8.8	760	126	2:17	6.5	moonquay c.CLEAR	\N	tictactoe	f	TAK x Corbin
1501	Tic! Tac! Toe!	ETR	9+	9.9	907	126	2:17	6.5	moonquay c.FAIL	\N	tictactoe	f	TAK x Corbin
1502	SATISFACTION	PST	3	3.5	580	180	2:29	6.6	Nitro	Yukinobu Ito (RICOL)	satisfaction	f	P*Light & DJ Noriken feat. KMNZ
1503	SATISFACTION	PRS	6	6.5	738	180	2:29	6.6	Nitro	Yukinobu Ito (RICOL)	satisfaction	f	P*Light & DJ Noriken feat. KMNZ
1504	SATISFACTION	FTR	8	8.5	890	180	2:29	6.6	Nitro	Yukinobu Ito (RICOL)	satisfaction	f	P*Light & DJ Noriken feat. KMNZ
1505	SATISFACTION	ETR	9	9.5	1047	180	2:29	6.6	Nitro	Yukinobu Ito (RICOL)	satisfaction	f	P*Light & DJ Noriken feat. KMNZ
1506	Someday	PST	3	3	367	136	2:01	6.6	sidewaves	\N	someday	f	NieN
1507	Someday	PRS	6	6	477	136	2:01	6.6	sidewaves + Nitro	\N	someday	f	NieN
1508	Someday	FTR	9	9.5	673	136	2:01	6.6	sidewaves + Exschwasion	\N	someday	f	NieN
1509	Miles	PST	3	3.5	385	130	2:11	6.6	Interator	\N	miles	f	Electronic Boutique
1510	Miles	PRS	6	6.5	548	130	2:11	6.6	Interator	\N	miles	f	Electronic Boutique
1511	Miles	FTR	8	8.2	687	130	2:11	6.6	Interator	\N	miles	f	Electronic Boutique
1512	Miles	ETR	9+	9.8	829	130	2:11	6.6	Interator	\N	miles	f	Electronic Boutique
1513	I want You	PST	3	3	326	140	1:48	6.6	Toaster	\N	iwantyou	f	Lin-G
1514	I want You	PRS	5	5.5	395	140	1:48	6.6	Toaster	\N	iwantyou	f	Lin-G
1515	I want You	FTR	8	8.3	528	140	1:48	6.6	Toaster	\N	iwantyou	f	Lin-G
1516	I want You	ETR	9	9.4	660	140	1:48	6.6	Toaster	\N	iwantyou	f	Lin-G
1517	Syriana	PST	4	4.5	490	135	2:07	6.6	RAYCAST [NM]	\N	syriana	f	BEXTER
1518	Syriana	PRS	7	7.5	516	135	2:07	6.6	RAYCAST [HD]	\N	syriana	f	BEXTER
1519	Syriana	FTR	9+	9.9	886	135	2:07	6.6	RAYCAST [MX]	\N	syriana	f	BEXTER
88	Flashback	PRS	5	5	488	195	2:02	1.0	Nitro	yoshimo	flashback	f	ARForest
1520	Liar	PST	4	4.5	461	140	2:15	6.6	Nitro	\N	liar	f	zts
1521	Liar	PRS	7+	7.8	614	140	2:15	6.6	Nitro	\N	liar	f	zts
1522	Liar	FTR	10	10	919	140	2:15	6.6	KLMNOP + Nitro	\N	liar	f	zts
1523	BlythE	PST	3	3	610	180	2:15	6.6	M理論	\N	blythe	f	M2U
1524	BlythE	PRS	7	7.5	729	180	2:15	6.6	M理論	\N	blythe	f	M2U
1525	BlythE	FTR	9	9.4	1000	180	2:15	6.6	M理論	\N	blythe	f	M2U
1526	BlythE	ETR	10	10.5	1207	180	2:15	6.6	M理論	\N	blythe	f	M2U
1527	We're All Gonna Die	PST	5	5.5	733	180	2:14	6.6	絶滅	\N	wereallgonnadie	f	Paul Bazooka
1528	We're All Gonna Die	PRS	8	8	864	180	2:14	6.6	絶滅	\N	wereallgonnadie	f	Paul Bazooka
1529	We're All Gonna Die	FTR	10	10.1	1147	180	2:14	6.6	絶滅	\N	wereallgonnadie	f	Paul Bazooka
1530	We're All Gonna Die	ETR	10+	10.9	1335	180	2:14	6.6	絶滅	\N	wereallgonnadie	f	Paul Bazooka
1531	Dematerialized	PST	1	1.5	469	86	2:04	6.7	karat	mw2k	dematerialized	f	In Love With A Ghost
1532	Dematerialized	PRS	4	4.5	659	86	2:04	6.7	karat	mw2k	dematerialized	f	In Love With A Ghost
1533	Dematerialized	FTR	7	7.5	722	86	2:04	6.7	karat	mw2k	dematerialized	f	In Love With A Ghost
1534	Dematerialized	ETR	8	8.3	790	86	2:04	6.7	karat	mw2k	dematerialized	f	In Love With A Ghost
1535	See the Lights!	PST	3	3.5	445	136	2:24	6.7	raycast☆	桑島黎音	seethelights	f	polysha feat. しろさきあや
1536	See the Lights!	PRS	6	6.5	582	136	2:24	6.7	raycast☆	桑島黎音	seethelights	f	polysha feat. しろさきあや
1537	See the Lights!	FTR	8	8.6	692	136	2:24	6.7	raycast☆	桑島黎音	seethelights	f	polysha feat. しろさきあや
1538	See the Lights!	ETR	9	9.6	844	136	2:24	6.7	raycast☆	桑島黎音	seethelights	f	polysha feat. しろさきあや
1539	Scarlet Lunar Empress	PST	3	3.5	609	108-184	2:26	6.7	青月sidewaves	祝く月	scarletlunar	f	technoplanet feat. 夕月ティア
1597	No Way Back	ETR	10	10.4	1008	153	2:13	6.9	「Nitro」	AT基調	nowayback	f	Nhato
1540	Scarlet Lunar Empress	PRS	7	7	698	108-184	2:26	6.7	青月sidewaves	祝く月	scarletlunar	f	technoplanet feat. 夕月ティア
1541	Scarlet Lunar Empress	FTR	9+	9.8	1037	108-184	2:26	6.7	青月sidewaves	祝く月	scarletlunar	f	technoplanet feat. 夕月ティア
1542	Dual Dependency	PST	4	4.5	607	155	2:30	6.7	絶∥滅	U0	dualdependency	f	seatrus
1543	Dual Dependency	PRS	7+	7.8	784	155	2:30	6.7	絶∥滅	U0	dualdependency	f	seatrus
1544	Dual Dependency	FTR	9	9.5	987	155	2:30	6.7	絶∥滅	U0	dualdependency	f	seatrus
1545	Dual Dependency	ETR	10	10.4	1162	155	2:30	6.7	絶∥滅	U0	dualdependency	f	seatrus
1546	Lilly	PST	5	5	865	235	2:40	6.7	反水【天龍】	イシダタツキ	lilly	f	Juggernaut.
1547	Lilly	PRS	8	8.4	1052	235	2:40	6.7	反水【天龍】	イシダタツキ	lilly	f	Juggernaut.
1548	Lilly	FTR	9+	9.9	1312	235	2:40	6.7	反水【天龍】	イシダタツキ	lilly	f	Juggernaut.
1549	Lilly	ETR	10+	10.8	1353	235	2:40	6.7	瑞獣【応龍】	イシダタツキ	lilly	f	Juggernaut.
1550	Extradimensional Cosmic Phenomenon	PST	6	6.5	1011	180-300	2:39	6.7	#0000遒ｧ	すずなし	extradimensional	f	TAKIO feat. つぐ
1551	Extradimensional Cosmic Phenomenon	PRS	8+	8.8	1193	180-300	2:39	6.7	#0000遒ｧ	すずなし	extradimensional	f	TAKIO feat. つぐ
1552	Extradimensional Cosmic Phenomenon	FTR	10	10.6	1422	180-300	2:39	6.7	#0000遒ｧ	すずなし	extradimensional	f	TAKIO feat. つぐ
1553	Extradimensional Cosmic Phenomenon	ETR	11	11.3	1726	180-300	2:39	6.7	#0000遒ｧ	すずなし	extradimensional	f	TAKIO feat. つぐ
1554	disintegration	PST	4	4	387	135	2:13	6.8	raycast	辷 + Vormis.	disintegration	f	ひゅ〜ぶ
1555	disintegration	PRS	6	6.5	466	135	2:13	6.8	raycast	辷 + Vormis.	disintegration	f	ひゅ〜ぶ
1556	disintegration	FTR	8	8.3	605	135	2:13	6.8	raycast	辷 + Vormis.	disintegration	f	ひゅ〜ぶ
1557	disintegration	ETR	9+	9.8	821	135	2:13	6.8	raycast	辷 + Vormis.	disintegration	f	ひゅ〜ぶ
1558	Factorder	PST	2	2.5	510	168	2:25	6.8	Luxance -Lost Colors-	KUREHA	factorder	f	瀬名 feat. 梨雛
1559	Factorder	PRS	6	6.5	663	168	2:25	6.8	Luxance -Lost Colors-	KUREHA	factorder	f	瀬名 feat. 梨雛
1560	Factorder	FTR	8	8.6	849	168	2:25	6.8	Nitro	KUREHA	factorder	f	瀬名 feat. 梨雛
1561	Factorder	ETR	9	9.6	1015	168	2:25	6.8	Luxance -Lost Colors-	KUREHA	factorder	f	瀬名 feat. 梨雛
1562	incomplete the one	PST	3	3.5	691	208	2:24	6.8	<>ntym1s	Tamaji	incompleteone	f	Halv feat.Kuroa*
1563	incomplete the one	PRS	7	7.5	848	208	2:24	6.8	<>ntym1s	Tamaji	incompleteone	f	Halv feat.Kuroa*
1564	incomplete the one	FTR	8+	8.8	912	208	2:24	6.8	<>ntym1s	Tamaji	incompleteone	f	Halv feat.Kuroa*
1565	incomplete the one	ETR	9+	9.9	1008	208	2:24	6.8	<>ntym1s	Tamaji	incompleteone	f	Halv feat.Kuroa*
1566	CHAOSBLAST	PST	4	4.5	786	480	2:23	6.8	NITRO「THE ANARQISM」	梅まろ + Vormis.	chaosblast	f	QURELESS + 柚子花
1567	CHAOSBLAST	PRS	7+	7.8	1000	480	2:23	6.8	NITRO「THE ANARQISM」	梅まろ + Vormis.	chaosblast	f	QURELESS + 柚子花
1568	CHAOSBLAST	FTR	9	9.6	1290	480	2:23	6.8	NITRO「THE ANARQISM」	梅まろ + Vormis.	chaosblast	f	QURELESS + 柚子花
1569	CHAOSBLAST	ETR	10	10.5	1539	480	2:23	6.8	NITRO「THE ANARQISM」	梅まろ + Vormis.	chaosblast	f	QURELESS + 柚子花
1570	Welcome, Queen of Fiction.	PST	5	5	610	110-305	2:36	6.8	ようこそ、瑞獣。	あらへなす	welcomequeen	f	打打だいず
1571	Welcome, Queen of Fiction.	PRS	8	8.5	832	110-305	2:36	6.8	ようこそ、瑞獣。	あらへなす	welcomequeen	f	打打だいず
1572	Welcome, Queen of Fiction.	FTR	10	10.1	1172	110-305	2:36	6.8	ようこそ、瑞獣。	あらへなす	welcomequeen	f	打打だいず
1573	Welcome, Queen of Fiction.	ETR	10+	10.9	1442	110-305	2:36	6.8	虚偽の玉座【夜浪】	あらへなす	welcomequeen	f	打打だいず
1574	AlterGate	PST	5	5.5	774	199	2:23	6.8	絶滅	辷	altergate	f	MisoilePunch♪ ~タケノコ添え~
1575	AlterGate	PRS	8+	8.7	993	199	2:23	6.8	絶滅	辷	altergate	f	MisoilePunch♪ ~タケノコ添え~
1576	AlterGate	FTR	10+	10.7	1324	199	2:23	6.8	絶滅	辷	altergate	f	MisoilePunch♪ ~タケノコ添え~
1578	Acheron	PRS	7	7.5	688	175-145	2:31	6.8	karat	こもり	acheron	f	KARUT
1579	Acheron	FTR	9+	9.7	1024	175-145	2:31	6.8	karat	こもり	acheron	f	KARUT
1580	Eternity Break	PST	3	3.5	634	170	2:42	6.8	M理論_halt	Khronetic -玄廻-	eternitybreak	f	Puru
1581	Eternity Break	PRS	7	7.5	882	170	2:42	6.8	M理論_halt	Khronetic -玄廻-	eternitybreak	f	Puru
1582	Eternity Break	FTR	9	9.6	1051	170	2:42	6.8	M理論_halt	Khronetic -玄廻-	eternitybreak	f	Puru
1583	Eternity Break	ETR	10	10.4	1155	170	2:42	6.8	M理論_halt	Khronetic -玄廻-	eternitybreak	f	Puru
1584	ROST PAGE GENE	PST	5	5	475	135	2:21	6.9	NEON:ROAD:OKAY	sashimi	rostpagegene	f	MYUKKE.
1585	ROST PAGE GENE	PRS	8	8.2	697	135	2:21	6.9	NEON:ROAD:OKAY	sashimi	rostpagegene	f	MYUKKE.
1586	ROST PAGE GENE	FTR	10	10.3	1028	135	2:21	6.9	NEON:ROAD:OKAY	sashimi	rostpagegene	f	MYUKKE.
1587	Viola Illyria	PST	2	2.5	539	162	2:37	6.9	sidewaves	ねこじし	violaillyria	f	Kolaa
1588	Viola Illyria	PRS	6	6.5	683	162	2:37	6.9	sidewaves	ねこじし	violaillyria	f	Kolaa
1589	Viola Illyria	FTR	9	9.5	927	162	2:37	6.9	sidewaves + Exschwasion	ねこじし	violaillyria	f	Kolaa
1590	Vainspire	PST	3	3.5	771	180	2:35	6.9	|karat|	雨儀	vainspire	f	satella
1591	Vainspire	PRS	7	7	787	180	2:35	6.9	|karat|	雨儀	vainspire	f	satella
1592	Vainspire	FTR	8	8.4	947	180	2:35	6.9	|karat|	雨儀	vainspire	f	satella
1593	Vainspire	ETR	9+	9.9	1133	180	2:35	6.9	|karat|	雨儀	vainspire	f	satella
1594	No Way Back	PST	4	4.5	564	153	2:13	6.9	「Nitro」	AT基調	nowayback	f	Nhato
1595	No Way Back	PRS	7	7.5	639	153	2:13	6.9	「Nitro」	AT基調	nowayback	f	Nhato
1596	No Way Back	FTR	8+	8.9	837	153	2:13	6.9	「Nitro」	AT基調	nowayback	f	Nhato
1598	ANDORXOR	PST	4	4.5	559	148	2:35	6.9	反∧水	南条まや + Vormis.	andorxor	f	Sobrem
1599	ANDORXOR	PRS	7+	7.8	758	148	2:35	6.9	反∧水	南条まや + Vormis.	andorxor	f	Sobrem
1600	ANDORXOR	FTR	9+	9.9	1055	148	2:35	6.9	反∧水	南条まや + Vormis.	andorxor	f	Sobrem
1601	ANDORXOR	ETR	10+	10.8	1404	148	2:35	6.9	反∧水	南条まや + Vormis.	andorxor	f	Sobrem
1602	Undying Macula	PST	5	5.5	883	63	2:43	6.9	PHOTONSPHERE	すずなし	undyingmacula	f	Ashrount
1603	Undying Macula	PRS	8+	8.7	904	63	2:43	6.9	ERGOSPHERE	すずなし	undyingmacula	f	Ashrount
1604	Undying Macula	FTR	10	10.1	1250	63	2:43	6.9	EVENTHORIZON	すずなし	undyingmacula	f	Ashrount
1605	Undying Macula	ETR	11	11	1461	63	2:43	6.9	M/V_BRIDGE	すずなし	undyingmacula	f	Ashrount
1606	Wake in Hour	PST	2	2.5	394	128	2:34	6.10	Luxance	しきみ	awakening	f	有村京悟 feat.July
1607	Wake in Hour	PRS	5	5.5	492	128	2:34	6.10	Luxance	しきみ	awakening	f	有村京悟 feat.July
1608	Wake in Hour	FTR	7	7.5	608	128	2:34	6.10	Luxance	しきみ	awakening	f	有村京悟 feat.July
1609	Wake in Hour	ETR	8+	8.7	726	128	2:34	6.10	Luxance	しきみ	awakening	f	有村京悟 feat.July
1610	mod	PST	3	3.5	572	168	2:23	6.10	karat	dD9	mod	f	kalsoer
1611	mod	PRS	6	6.5	676	168	2:23	6.10	karat	dD9	mod	f	kalsoer
1612	mod	FTR	9	9.4	853	168	2:23	6.10	karat	dD9	mod	f	kalsoer
1613	Particle	PST	3	3.5	519	142	2:16	6.10	M理論	Lime	particle	f	Lime / Kankitsu
1614	Particle	PRS	6	6	613	142	2:16	6.10	M理論	Lime	particle	f	Lime / Kankitsu
1615	Particle	FTR	9	9.5	890	142	2:16	6.10	M理論_charmq	Lime	particle	f	Lime / Kankitsu
1616	Particle	ETR	9+	9.7	881	142	2:16	6.10	M理論_strangeq	Lime	particle	f	Lime / Kankitsu
1617	Paradox Palette	PST	4	4	476	152	2:25	6.10	antymis.	HouKou	paradoxpalette	f	Aethoro
1618	Paradox Palette	PRS	7	7.5	653	152	2:25	6.10	antymis.	HouKou	paradoxpalette	f	Aethoro
1619	Paradox Palette	FTR	8+	8.8	814	152	2:25	6.10	antymis.	HouKou	paradoxpalette	f	Aethoro
1620	Paradox Palette	ETR	9+	9.9	1043	152	2:25	6.10	antymis.	HouKou	paradoxpalette	f	Aethoro
1621	Xxium and Purple haze	PST	2	2.5	768	165	2:25	6.10	ẋx	D.watt	xxium	f	D.watt
1622	Xxium and Purple haze	PRS	7+	7.8	806	165	2:25	6.10	ẋx	D.watt	xxium	f	D.watt
1623	Xxium and Purple haze	FTR	9+	9.9	1182	165	2:25	6.10	ẋx	D.watt	xxium	f	D.watt
1624	Xxium and Purple haze	ETR	10	10.5	1096	165	2:25	6.10	ẋx	D.watt	xxium	f	D.watt
1625	Angel's Boundary	PST	5	5	841	196	2:39	6.10	[絶,滅)	ぽ院	angelsboundary	f	MEMODEMO
1626	Angel's Boundary	PRS	8	8.5	1013	196	2:39	6.10	[絶,滅)	ぽ院	angelsboundary	f	MEMODEMO
1627	Angel's Boundary	FTR	10	10.2	1246	196	2:39	6.10	[絶,滅)	ぽ院	angelsboundary	f	MEMODEMO
1628	Xterfusion	PST	4	4.5	640	128-256	2:48	6.10	Nitro -fuze- 夜浪	すずなし + Vormis.	xterfusion	f	REDALiCE × t+pazolite
1629	Xterfusion	PRS	8	8.3	924	128-256	2:48	6.10	Nitro -fuze- 夜浪	すずなし + Vormis.	xterfusion	f	REDALiCE × t+pazolite
68	Dement ~after legend~	PST	3	3.5	548	210	2:09	1.0	Toaster	\N	dement	f	Cosmograph
1630	Xterfusion	FTR	9+	9.8	1138	128-256	2:48	6.10	Nitro -fuze- 夜浪	すずなし + Vormis.	xterfusion	f	REDALiCE × t+pazolite
1631	Xterfusion	ETR	10+	10.7	1441	128-256	2:48	6.10	Nitro -fuze- 夜浪	すずなし + Vormis.	xterfusion	f	REDALiCE × t+pazolite
1632	INFINITE DIMENSION	PST	2	2.5	566	200	2:22	6.10	én	海谷内藤	infinitedim	f	DJ Noriken × P*Light
1633	INFINITE DIMENSION	PRS	6	6	708	200	2:22	6.10	én	海谷内藤	infinitedim	f	DJ Noriken × P*Light
1634	INFINITE DIMENSION	FTR	8	8.6	947	200	2:22	6.10	én	海谷内藤	infinitedim	f	DJ Noriken × P*Light
1635	INFINITE DIMENSION	ETR	10	10.1	1111	200	2:22	6.10	ray∞cast	海谷内藤	infinitedim	f	DJ Noriken × P*Light
1636	INCARNATOR₀₀	PST	3	3.5	1178	234	2:54	6.10	M理論_origin	辷 × N²/ANTIREAL	incarnator	f	Silentroom × N²
1637	INCARNATOR₀₀	PRS	6	6.5	1276	234	2:54	6.10	M理論_origin	辷 × N²/ANTIREAL	incarnator	f	Silentroom × N²
1638	INCARNATOR₀₀	FTR	8+	8.9	1565	234	2:54	6.10	M理論_origin	辷 × N²/ANTIREAL	incarnator	f	Silentroom × N²
1639	INCARNATOR₀₀	ETR	10	10.4	1355	234	2:54	6.10	antymis [archetype]	辷 × N²/ANTIREAL	incarnator	f	Silentroom × N²
1640	zephyrlasting	PST	3	3.5	563	155	2:37	6.10	Souplex	Men	zephyrlast	f	s-don × nitro (lowiro)
1641	zephyrlasting	PRS	7	7.5	832	155	2:37	6.10	Souplex	Men	zephyrlast	f	s-don × nitro (lowiro)
1642	zephyrlasting	FTR	9	9.5	1027	155	2:37	6.10	Souplex + Nitro	Men	zephyrlast	f	s-don × nitro (lowiro)
1643	zephyrlasting	ETR	10	10.3	1166	155	2:37	6.10	Nitro 「The Timeless」	Men	zephyrlast	f	s-don × nitro (lowiro)
1644	MARENYX	PST	4	4.5	886	195	2:45	6.10	raycast against. 零下	かえで《もみじの木》	marenyx	f	BlackY × Aoi
1645	MARENYX	PRS	7+	7.8	1143	195	2:45	6.10	raycast against. 零下	かえで《もみじの木》	marenyx	f	BlackY × Aoi
1646	MARENYX	FTR	9	9.5	1307	195	2:45	6.10	raycast against. 零下	かえで《もみじの木》	marenyx	f	BlackY × Aoi
1647	MARENYX	ETR	10+	10.8	1500	195	2:45	6.10	raycast against. 零下	かえで《もみじの木》	marenyx	f	BlackY × Aoi
1648	Code: Oblivion	PST	5	5.5	773	200	2:35	6.10	~sidewaves	MILKteaWegan	codeoblivion	f	Kobaryo × Gram
1649	Code: Oblivion	PRS	8	8.3	1015	200	2:35	6.10	~sidewaves	MILKteaWegan	codeoblivion	f	Kobaryo × Gram
1650	Code: Oblivion	FTR	9+	9.9	1281	200	2:35	6.10	~sidewaves	MILKteaWegan	codeoblivion	f	Kobaryo × Gram
1651	Code: Oblivion	ETR	10+	10.9	1503	200	2:35	6.10	煌磨	MILKteaWegan	codeoblivion	f	Kobaryo × Gram
1652	ΛZΛLEΛ	PST	4	4	847	180	2:36	6.10	Nitro「The Ephemeral」	辷 + Vormis.	azalea	f	ak+q × onoken
1653	ΛZΛLEΛ	PRS	7	7	973	180	2:36	6.10	Nitro「The Ephemeral」	辷 + Vormis.	azalea	f	ak+q × onoken
1654	ΛZΛLEΛ	FTR	9	9.4	1144	180	2:36	6.10	Nitro「The Ephemeral」	辷 + Vormis.	azalea	f	ak+q × onoken
1655	ΛZΛLEΛ	ETR	10	10	1075	180	2:36	6.10	NORΛ::NEKO × KΛRΛT	辷 + Vormis.	azalea	f	ak+q × onoken
1656	taboo tears you up 2017	PST	3	3	449	180	2:20	6.11	SiDEWAVES	ほまでり	tabootears	f	REDALiCE
1657	taboo tears you up 2017	PRS	6	6.5	637	180	2:20	6.11	SiDEWAVES	ほまでり	tabootears	f	REDALiCE
1658	taboo tears you up 2017	FTR	8	8.4	845	180	2:20	6.11	SiDEWAVES	ほまでり	tabootears	f	REDALiCE
1659	taboo tears you up 2017	ETR	9+	9.8	1125	180	2:20	6.11	én	ほまでり	tabootears	f	REDALiCE
1660	Grandspell	PST	4	4.5	704	168	2:48	6.11	Exschwasion	KUREHA + Vormis.	grandspell	f	Hylen
1661	Grandspell	PRS	8	8.4	977	168	2:48	6.11	Exschwasion	KUREHA + Vormis.	grandspell	f	Hylen
1662	Grandspell	FTR	10	10.2	1289	168	2:48	6.11	Exschwasion	KUREHA + Vormis.	grandspell	f	Hylen
1663	undefined	PST	3	3.5	371	110	2:25	6.11	sidewaves	るあえる	undefined	f	planless & 乃花こより
1664	undefined	PRS	6	6	532	110	2:25	6.11	sidewaves	るあえる	undefined	f	planless & 乃花こより
1665	undefined	FTR	9	9.4	896	110	2:25	6.11	sidewaves + Nitro	るあえる	undefined	f	planless & 乃花こより
1666	~_+	PST	4	4.5	869	213.5	2:38	6.11	KARA+_~1.TMP	なのに！ + Vormis.	mask	f	AQUASINE ~ MEMODEMO + METAROOM
1667	~_+	PRS	8	8	994	213.5	2:38	6.11	KARA+_~1.TMP	なのに！ + Vormis.	mask	f	AQUASINE ~ MEMODEMO + METAROOM
1668	~_+	FTR	9+	9.9	1201	213.5	2:38	6.11	KARA+_~1.TMP	なのに！ + Vormis.	mask	f	AQUASINE ~ MEMODEMO + METAROOM
1669	Paranoid Arc	PST	4	4.5	762	180	2:38	6.11	Exschwasion v.●/○/○	まるい	paranoidarc	f	t+pazolite
1670	Paranoid Arc	PRS	7+	7.8	849	180	2:38	6.11	Exschwasion v.●/○/○	まるい	paranoidarc	f	t+pazolite
1671	Paranoid Arc	FTR	9	9.6	1204	180	2:38	6.11	Exschwasion v.●/○/○	まるい	paranoidarc	f	t+pazolite
1672	Paranoid Arc	ETR	10	10.5	1412	180	2:38	6.11	Exschwasion v.●/○/○	まるい	paranoidarc	f	t+pazolite
1673	Subsphere in Eclosion	PST	5	5	781	120	2:27	6.11	Nitro v.○/●/○	scocasr	subsphere	f	窓辺リカ
1674	Subsphere in Eclosion	PRS	8	8.1	997	120	2:27	6.11	Nitro v.○/●/○	scocasr	subsphere	f	窓辺リカ
1675	Subsphere in Eclosion	FTR	9	9.6	1177	120	2:27	6.11	Nitro v.○/●/○	scocasr	subsphere	f	窓辺リカ
1676	Subsphere in Eclosion	ETR	10	10.6	1327	120	2:27	6.11	Nitro v.○/●/○	scocasr	subsphere	f	窓辺リカ
1677	The 'Raft' taught me: your heart will always find a way.	PST	4	4.5	722	161	2:39	6.11	Interator	色塩	theraft	f	庭師
1685	CHAIN2NITE	PRS	6	6.5	759	172	2:31	6.12	raycast	Poyoshi	chaintonite	f	asuzora feat. cyber milk ちゃん
3	Sayonara Hatsukoi	FTR	7	7	666	178	1:55	1.0	Toaster	\N	sayonarahatsukoi	f	REDSHiFT
4	Sayonara Hatsukoi	ETR	8	8.5	728	178	1:55	5.4	Luxance + Exschwasion	\N	sayonarahatsukoi	f	REDSHiFT
1686	CHAIN2NITE	FTR	8	8.6	883	172	2:31	6.12	raycast	Poyoshi	chaintonite	f	asuzora feat. cyber milk ちゃん
1687	CHAIN2NITE	ETR	9+	9.9	1037	172	2:31	6.12	raycast	Poyoshi	chaintonite	f	asuzora feat. cyber milk ちゃん
1688	One Step Closer	PST	3	3.5	454	123	2:26	6.12	Nitroだー！	Poyoshi + はぐはむ	onestepcloser	f	Mameyudoufu × 藍月なくる
1689	One Step Closer	PRS	7	7	551	123	2:26	6.12	Nitroだー！	Poyoshi + はぐはむ	onestepcloser	f	Mameyudoufu × 藍月なくる
1690	One Step Closer	FTR	9	9.5	752	123	2:26	6.12	Nitroだー！	Poyoshi + はぐはむ	onestepcloser	f	Mameyudoufu × 藍月なくる
1691	My life is mine alone!	PST	2	2.5	460	144-168	2:48	6.12	Nitro	Poyoshi	mylifeismine	f	Mylta feat. ねんね
1692	My life is mine alone!	PRS	5	5.5	612	144-168	2:48	6.12	Nitro	Poyoshi	mylifeismine	f	Mylta feat. ねんね
1693	My life is mine alone!	FTR	8+	8.8	933	144-168	2:48	6.12	Nitro	Poyoshi	mylifeismine	f	Mylta feat. ねんね
1694	My life is mine alone!	ETR	10	10.1	1075	144-168	2:48	6.12	antymis	Poyoshi	mylifeismine	f	Mylta feat. ねんね
1695	Melty Rhapsody	PST	3	3.5	582	156	2:36	6.12	M理論_liquid	辷 + Vormis.	meltyrhapsody	f	lapix feat. PANXI
1696	Melty Rhapsody	PRS	7	7.5	790	156	2:36	6.12	M理論_liquid	辷 + Vormis.	meltyrhapsody	f	lapix feat. PANXI
1697	Melty Rhapsody	FTR	9	9.6	975	156	2:36	6.12	M理論_liquid	辷 + Vormis.	meltyrhapsody	f	lapix feat. PANXI
1698	Melty Rhapsody	ETR	10	10.4	1185	156	2:36	6.12	M理論_liquid	辷 + Vormis.	meltyrhapsody	f	lapix feat. PANXI
1700	Signal	PRS	7+	7.8	824	175	2:45	6.12	én	Poyoshi	signal	f	rejection feat. Such
1701	Signal	FTR	9+	9.8	1151	175	2:45	6.12	én	Poyoshi	signal	f	rejection feat. Such
1702	Signal	ETR	10+	10.7	1245	175	2:45	6.12	絶滅	Poyoshi	signal	f	rejection feat. Such
1703	Gimme Caramel Popcorn!	PST	2	2.5	610	180	2:25	6.12	Interator	さじ	caramelpop	f	ヤミナベレコーズ feat. 繭糸
1704	Gimme Caramel Popcorn!	PRS	5	5.5	579	180	2:25	6.12	Interator	さじ	caramelpop	f	ヤミナベレコーズ feat. 繭糸
1705	Gimme Caramel Popcorn!	FTR	8	8.1	767	180	2:25	6.12	Interator	さじ	caramelpop	f	ヤミナベレコーズ feat. 繭糸
1706	Gimme Caramel Popcorn!	ETR	9	9.1	959	180	2:25	6.12	Interator	さじ	caramelpop	f	ヤミナベレコーズ feat. 繭糸
1707	The Forgotten Forest Haven	PST	3	3.5	582	192	2:43	6.12	Nitro	atra	shinoukyoseki	f	ShiBa
1708	The Forgotten Forest Haven	PRS	6	6.5	748	192	2:43	6.12	Nitro	atra	shinoukyoseki	f	ShiBa
1709	The Forgotten Forest Haven	FTR	9+	9.7	1065	192	2:43	6.12	Nitro	atra	shinoukyoseki	f	ShiBa
1710	+1(UNKNOWN)-NUMBER	PST	4	4	486	145	2:25	6.12	M理論_GSM	AQUASINE	unknownnum	f	MEMODEMO × AQUASINE ^ (hackerling)
1711	+1(UNKNOWN)-NUMBER	PRS	7	7	619	145	2:25	6.12	M理論_GSM	AQUASINE	unknownnum	f	MEMODEMO × AQUASINE ^ (hackerling)
1712	+1(UNKNOWN)-NUMBER	FTR	9+	9.7	882	145	2:25	6.12	M理論_GSM	AQUASINE	unknownnum	f	MEMODEMO × AQUASINE ^ (hackerling)
1713	3rd Avenue	PST	3	3	529	130	2:38	6.13	Souplex	Jehyun, Piranesi	thirdavenue	f	Sound Souler
1714	3rd Avenue	PRS	8	8.1	761	130	2:38	6.13	Souplex	Jehyun, Piranesi	thirdavenue	f	Sound Souler
1715	3rd Avenue	FTR	9	9.2	748	130	2:38	6.13	New Dimensions	Jehyun, Piranesi	thirdavenue	f	Sound Souler
1716	Vallista	PST	4	4.5	548	180	2:07	6.13	sidewaves	Mentalstock	vallista	f	Sakuzyo
1717	Vallista	PRS	7+	7.8	681	180	2:07	6.13	sidewaves	Mentalstock	vallista	f	Sakuzyo
1718	Vallista	FTR	9+	9.7	869	180	2:07	6.13	sidewaves	Mentalstock	vallista	f	Sakuzyo
1719	GOODRAGE	PST	4	4.5	576	222	2:00	6.13	Interator	EBIMAYO	goodrage	f	EBIMAYO
1720	GOODRAGE	PRS	7+	7.8	702	222	2:00	6.13	Interator	EBIMAYO	goodrage	f	EBIMAYO
1721	GOODRAGE	FTR	9	9.3	834	222	2:00	6.13	Interator	EBIMAYO	goodrage	f	EBIMAYO
1722	GOODRAGE	ETR	10	10.2	1035	222	2:00	6.13	NORANEKO	EBIMAYO	goodrage	f	EBIMAYO
1723	Cryogenic	PST	5	5	510	145	2:20	6.13	raycast /connected/	アオノアオ + Vormis.	cryogenic	f	Camellia ft. Petra Gurin
1724	Cryogenic	PRS	7	7.5	680	145	2:20	6.13	raycast /connected/	アオノアオ + Vormis.	cryogenic	f	Camellia ft. Petra Gurin
1725	Cryogenic	FTR	9	9.2	831	145	2:20	6.13	raycast /connected/	アオノアオ + Vormis.	cryogenic	f	Camellia ft. Petra Gurin
1726	Cryogenic	ETR	10	10.1	1014	145	2:20	6.13	raycast /connected/	アオノアオ + Vormis.	cryogenic	f	Camellia ft. Petra Gurin
1727	Desertrealm	PST	4	4.5	843	216	2:34	6.13	karat -weathered-	フリッツ	desertrealm	f	Masahiro "Godspeed" Aoki
1728	Desertrealm	PRS	8	8.5	1000	216	2:34	6.13	karat -weathered-	フリッツ	desertrealm	f	Masahiro "Godspeed" Aoki
1729	Desertrealm	FTR	10	10.6	1460	216	2:34	6.13	karat -weathered-	フリッツ	desertrealm	f	Masahiro "Godspeed" Aoki
1730	Spider Dance	PST	2	2.5	525	230	1:47	6.14	24 KARAT GOLD	\N	spiderdance	f	Toby Fox
1731	Spider Dance	PRS	5	5.5	526	230	1:47	6.14	24 KARAT GOLD	\N	spiderdance	f	Toby Fox
1732	Spider Dance	FTR	7+	7.8	553	230	1:47	6.14	24 KARAT GOLD	\N	spiderdance	f	Toby Fox
1733	Spider Dance	ETR	9	9.5	666	230	1:47	6.14	24 KARAT GOLD	\N	spiderdance	f	Toby Fox
1734	Spear of Justice	PST	3	3.5	308	263	1:56	6.14	antymis	\N	spearofjustice	f	Toby Fox
89	Flashback	FTR	8+	8.9	856	195	2:02	1.0	Nitro	yoshimo	flashback	f	ARForest
258	Be There	PST	4	4	592	164	2:11	1.6	Nitro	hie	bethere	f	PSYQUI
394	Grimheart	PST	2	2.5	728	170	2:30	2.0	Toaster	\N	grimheart	f	Puru
446	Diode	PST	2	2.5	452	132	2:20	2.4	Kurorak	キッカイキ	diode	f	Kolaa
630	April showers	PST	2	2	363	79	2:09	3.4	Nitro-100号	\N	aprilshowers	f	cubesato
839	DDD	PST	2	2.5	363	138	1:58	3.12	én	わっふゑ	ddd	f	はがね
901	Last	PST	4	4	680	175	2:27	4.0	Arcaea	シエラ	last	f	onoken
1274	shrink	FTR	9+	9.8	939	180	2:02	5.9	Dec18	\N	shrink	f	Shohei Tsuchiya(ZUNTATA)
1577	Acheron	PST	3	3.5	538	175-145	2:31	6.8	karat	こもり	acheron	f	KARUT
1699	Signal	PST	4	4	582	175	2:45	6.12	én	Poyoshi	signal	f	rejection feat. Such
1741	ASGORE	ETR	10	10.2	1255	229.69	2:37	6.14	sidewaves -Bergentrückung-	\N	asgore	f	Toby Fox
1742	MIRROR - kamome sano remix	PST	4	4	654	177	2:22	6.14	nora::neko	Eli Stavridis	mirrorrmx	f	kamome sano
1743	MIRROR - kamome sano remix	PRS	7	7	742	177	2:22	6.14	nora::neko	Eli Stavridis	mirrorrmx	f	kamome sano
1744	MIRROR - kamome sano remix	FTR	9+	9.9	972	177	2:22	6.14	nora::neko	Eli Stavridis	mirrorrmx	f	kamome sano
1745	Riot in the System	PST	4	4.5	755	200	2:31	6.14	Interioter	Yukinobu Ito (RICOL)	riotsystem	f	Laur & Massive New Krew feat. 社築
1746	Riot in the System	PRS	7	7.5	782	200	2:31	6.14	Interioter	Yukinobu Ito (RICOL)	riotsystem	f	Laur & Massive New Krew feat. 社築
1747	Riot in the System	FTR	9	9.5	998	200	2:31	6.14	Interioter	Yukinobu Ito (RICOL)	riotsystem	f	Laur & Massive New Krew feat. 社築
1748	Riot in the System	ETR	10	10.1	1214	200	2:31	6.14	Interioter	Yukinobu Ito (RICOL)	riotsystem	f	Laur & Massive New Krew feat. 社築
1749	Cosmogyral	PST	2	2.5	547	180	2:25	6.14	Interator	57_dayo	cosmogyral	f	Darren + Altermis
1750	Cosmogyral	PRS	5	5.5	687	180	2:25	6.14	Interator	57_dayo	cosmogyral	f	Darren + Altermis
1751	Cosmogyral	FTR	8	8.6	916	180	2:25	6.14	Interator	57_dayo	cosmogyral	f	Darren + Altermis
1752	Cosmogyral	ETR	9+	9.8	1049	180	2:25	6.14	Interator	57_dayo	cosmogyral	f	Darren + Altermis
1753	flexidefine	PST	2	2	644	197	2:24	6.14	flexi::feline	Lamanya	flexidefine	f	Lamanya
1754	flexidefine	PRS	6	6	842	197	2:24	6.14	flexi::feline	Lamanya	flexidefine	f	Lamanya
1755	flexidefine	FTR	9+	9.9	1055	197	2:24	6.14	flexi::feline	Lamanya	flexidefine	f	Lamanya
1756	Altersist	PST	2	2.5	454	138	2:55	6.14	sidewaves	HARDLOVE	altersist	f	void (Mournfinale)
1757	Altersist	PRS	6	6	621	138	2:55	6.14	sidewaves	HARDLOVE	altersist	f	void (Mournfinale)
1758	Altersist	FTR	8	8.4	803	138	2:55	6.14	sidewaves	HARDLOVE	altersist	f	void (Mournfinale)
1759	Altersist	ETR	9+	9.8	1077	138	2:55	6.14	sidewaves	HARDLOVE	altersist	f	void (Mournfinale)
1761	c.s.q.n.	PRS	7	7.5	625	174	2:04	6.14	Nitro	出前	csqn	f	Aoi
1762	c.s.q.n.	FTR	9	9.6	923	174	2:04	6.14	Nitro	出前	csqn	f	Aoi
1763	c.s.q.n.	ETR	10	10.3	1071	174	2:04	6.14	Nitro	出前	csqn	f	Aoi
1764	Sucromania	PST	3	3	477	148	2:27	6.15	Souplex	獏井 夢	sucromania	f	STEAKA
1765	Sucromania	PRS	6	6.5	731	148	2:27	6.15	Souplex	獏井 夢	sucromania	f	STEAKA
1766	Sucromania	FTR	9	9.1	951	148	2:27	6.15	Souplex	獏井 夢	sucromania	f	STEAKA
1767	Sucromania	ETR	10	10.1	1216	148	2:27	6.15	karat	獏井 夢	sucromania	f	STEAKA
1768	Lavie	PST	3	3.5	598	183	2:29	6.15	Nitro	\N	lavie	f	すりぃ
1769	Lavie	PRS	6	6	698	183	2:29	6.15	Nitro	\N	lavie	f	すりぃ
1770	Lavie	FTR	8+	8.8	903	183	2:29	6.15	Nitro	\N	lavie	f	すりぃ
1771	Lavie	ETR	9+	9.9	1125	183	2:29	6.15	sidewavesチュウ	\N	lavie	f	すりぃ
5	Lost Civilization	PST	4	4	462	75 - 210	2:04	1.0	Toaster	\N	lostcivilization	f	Laur vs CK
1678	The 'Raft' taught me: your heart will always find a way.	PRS	7	7.5	803	161	2:39	6.11	Interator	色塩	theraft	f	庭師
1679	The 'Raft' taught me: your heart will always find a way.	FTR	9	9.5	999	161	2:39	6.11	Interator	色塩	theraft	f	庭師
1680	The 'Raft' taught me: your heart will always find a way.	ETR	10	10.4	1193	161	2:39	6.11	raycast v.○/○/●	色塩	theraft	f	庭師
1681	OMAJINAI	PST	2	2.5	288	133	2:22	6.12	Souplex	Poyoshi + 内山ユニコ	omajinai	f	Tsubusare BOZZ × Madoka*
1682	OMAJINAI	PRS	7	7	572	133	2:22	6.12	Souplex	Poyoshi + 内山ユニコ	omajinai	f	Tsubusare BOZZ × Madoka*
1683	OMAJINAI	FTR	9	9.4	886	133	2:22	6.12	Souplex	Poyoshi + 内山ユニコ	omajinai	f	Tsubusare BOZZ × Madoka*
1684	CHAIN2NITE	PST	4	4	723	172	2:31	6.12	raycast	Poyoshi	chaintonite	f	asuzora feat. cyber milk ちゃん
1772	God-ish	PST	3	3.5	522	103-142	2:32	6.15	絶滅っぽいな	\N	kamippoi	f	ピノキオピー
1773	God-ish	PRS	7	7	645	103-142	2:32	6.15	絶滅っぽいな	\N	kamippoi	f	ピノキオピー
1774	God-ish	FTR	9	9.3	945	103-142	2:32	6.15	絶滅っぽいな	\N	kamippoi	f	ピノキオピー
1775	God-ish	ETR	10	10	1116	103-142	2:32	6.15	絶滅っぽいな	\N	kamippoi	f	ピノキオピー
1776	Override	PST	4	4	583	204	2:19	6.15	sudo M理論	辷 + SARYN	override	f	吉田夜世
1777	Override	PRS	7	7.5	723	204	2:19	6.15	sudo M理論	辷 + SARYN	override	f	吉田夜世
1778	Override	FTR	9	9.5	917	204	2:19	6.15	sudo M理論	辷 + SARYN	override	f	吉田夜世
1779	Override	ETR	10	10.2	1083	204	2:19	6.15	sudo M理論	辷 + SARYN	override	f	吉田夜世
1780	Telepathy	PST	4	4.5	484	205	2:18	6.15	;-b	\N	telepathy	f	DECO*27
1781	Telepathy	PRS	7+	7.8	766	205	2:18	6.15	;-b	\N	telepathy	f	DECO*27
1782	Telepathy	FTR	9	9.6	880	205	2:18	6.15	;-b	\N	telepathy	f	DECO*27
1783	Telepathy	ETR	10	10.4	1131	205	2:18	6.15	;-b	\N	telepathy	f	DECO*27
1784	Love me, Love me, Love me	PST	3	3.5	676	230	2:08	6.15	反水反水反水	\N	aishite	f	きくお
1785	Love me, Love me, Love me	PRS	6	6.5	799	230	2:08	6.15	反水反水反水	\N	aishite	f	きくお
1786	Love me, Love me, Love me	FTR	8+	8.7	837	230	2:08	6.15	反水反水反水	\N	aishite	f	きくお
1787	Love me, Love me, Love me	ETR	10	10.5	1039	230	2:08	6.15	煌磨煌磨煌磨	\N	aishite	f	きくお
1788	Synthesis.	PST	4	4	764	180	2:42	6.16	Souplex	AT基調	synthesis	f	tn-shi
1789	Synthesis.	PRS	8	8.2	1109	180	2:42	6.16	Souplex	AT基調	synthesis	f	tn-shi
1790	Synthesis.	FTR	9+	9.7	1192	180	2:42	6.16	Souplex	AT基調	synthesis	f	tn-shi
1791	Synthesis.	ETR	10	10.5	1469	180	2:42	6.16	Synthesis.raycast()	AT基調	synthesis	f	tn-shi
1792	Acid God	PST	4	4.5	554	160	2:26	6.16	nora::pengin	\N	acidgod	f	Yuta Imai
1793	Acid God	PRS	7+	7.8	748	160	2:26	6.16	nora::pengin	\N	acidgod	f	Yuta Imai
1794	Acid God	FTR	9+	9.9	1060	160	2:26	6.16	nora::pengin	\N	acidgod	f	Yuta Imai
1795	Acid God	ETR	10+	10.9	1379	160	2:26	6.16	終点	\N	acidgod	f	Yuta Imai
3595	DIE IN	PST	5	5	806	160-230	\N	7.0	antymIV	\N	diein	f	TAK x Sobrem
3596	DIE IN	PRS	8	8.3	957	160-230	\N	7.0	antymIV	\N	diein	f	TAK x Sobrem
3597	DIE IN	FTR	10	10.3	1160	160-230	\N	7.0	antymIV	\N	diein	f	TAK x Sobrem
1735	Spear of Justice	PRS	6	6.5	452	263	1:56	6.14	antymis	\N	spearofjustice	f	Toby Fox
1736	Spear of Justice	FTR	8	8.6	607	263	1:56	6.14	antymis	\N	spearofjustice	f	Toby Fox
1737	Spear of Justice	ETR	9+	9.9	761	263	1:56	6.14	antymis	\N	spearofjustice	f	Toby Fox
1738	ASGORE	PST	4	4.5	797	229.69	2:37	6.14	Nitro	\N	asgore	f	Toby Fox
1739	ASGORE	PRS	7	7.5	1044	229.69	2:37	6.14	Souplex	\N	asgore	f	Toby Fox
1740	ASGORE	FTR	8+	8.8	1006	229.69	2:37	6.14	Souplex + Nitro	\N	asgore	f	Toby Fox
1760	c.s.q.n.	PST	4	4	418	174	2:04	6.14	Nitro	出前	csqn	f	Aoi
3598	DIE IN	ETR	11	11.1	1474	160-230	\N	7.0	Beyond the ExtinctioIV	\N	diein	f	TAK x Sobrem
1796	chronologia	PST	4	4.5	790	180	2:50	6.16	Nitro	Khronetic x SARYN	chronologia	f	lowiro Sound Team (ak+q x nitro)
1797	chronologia	PRS	7+	7.8	1051	180	2:50	6.16	Nitro	Khronetic x SARYN	chronologia	f	lowiro Sound Team (ak+q x nitro)
1798	chronologia	FTR	9+	9.8	1230	180	2:50	6.16	Nitro	Khronetic x SARYN	chronologia	f	lowiro Sound Team (ak+q x nitro)
1799	chronologia	ETR	10+	10.8	1468	180	2:50	6.16	Nitro x Toaster	Khronetic x SARYN	chronologia	f	lowiro Sound Team (ak+q x nitro)
3603	Balor	PST	3	3.5	677	157	\N	7.0	karat, the Piercing Eye	イシダタツキ	balor	f	Redsign
3604	Balor	PRS	6	7.5	673	157	\N	7.0	karat, the Piercing Eye	イシダタツキ	balor	f	Redsign
3605	Balor	FTR	9	9.5	900	157	\N	7.0	karat, the Piercing Eye	イシダタツキ	balor	f	Redsign
3606	Balor	ETR	10	10.1	1138	157	\N	7.0	karat, the Piercing Eye	イシダタツキ	balor	f	Redsign
3607	DREAD AREA	PST	5	5.5	858	205	\N	7.0	絶滅「天道」	あらへなす	dreadarea	f	Ashrount vs. 打打だいず
3608	DREAD AREA	PRS	8	8.3	1002	205	\N	7.0	絶滅「天道」	あらへなす	dreadarea	f	Ashrount vs. 打打だいず
3609	DREAD AREA	FTR	10	10.3	1405	205	\N	7.0	絶滅「天道」	あらへなす	dreadarea	f	Ashrount vs. 打打だいず
7267	DREAD AREA	INS	11	11.4	1663	205	\N	7.0	絶滅「天道」	あらへなす	dreadarea	f	Ashrount vs. 打打だいず
3611	un	PST	4	4.5	853	188	\N	7.0	én「The Resolute」	_ziro	un	f	黒魔
3612	un	PRS	7+	7.8	1040	188	\N	7.0	én「The Resolute」	_ziro	un	f	黒魔
3613	un	FTR	9+	9.9	1502	188	\N	7.0	én「The Resolute」	_ziro	un	f	黒魔
3614	un	ETR	10+	10.9	1823	188	\N	7.0	NITRO「The Absolute」	_ziro	un	f	黒魔
3615	Riven Pilgrimage	PST	5	5.5	889	180	\N	7.0	零下「kuratoro」	雨儀	rivenpilgrim	f	rejection & Supire feat. eili
3616	Riven Pilgrimage	PRS	8	8.5	1052	180	\N	7.0	零下「kuratoro」	雨儀	rivenpilgrim	f	rejection & Supire feat. eili
3617	Riven Pilgrimage	FTR	10	10.4	1503	180	\N	7.0	零下「kuratoro」	雨儀	rivenpilgrim	f	rejection & Supire feat. eili
7275	Riven Pilgrimage	INS	11	11.5	2032	180	\N	7.0	零下 vs 夜浪「gardantoj」	雨儀	rivenpilgrim	f	rejection & Supire feat. eili
3619	Cataclysm Cry	PST	6	6.5	920	180	\N	7.0	運命の響 -echo of fate-	すずなし	cataclysmcry	f	Aid
3620	Cataclysm Cry	PRS	8+	8.8	1137	180	\N	7.0	運命の目 -eye of fate-	すずなし	cataclysmcry	f	Aid
3621	Cataclysm Cry	FTR	10	10.6	1614	180	\N	7.0	運命の手 -hand of fate-	すずなし	cataclysmcry	f	Aid
7279	Cataclysm Cry	INS	11+	11.8	2119	180	\N	7.0	運命の淵 -threshold of fate-	すずなし	cataclysmcry	f	Aid
3623	DEINOS PHAINEIN	PST	7	7.5	1008	190	\N	7.0	DIVINE INSIGHT ⟦識眼⟧	すずなし	deinosphainein	f	Blacklolita vs Juggernaut.
3624	DEINOS PHAINEIN	PRS	9	9.6	1178	190	\N	7.0	DIVINE KNOWLEDGE ⟦叡智⟧	すずなし	deinosphainein	f	Blacklolita vs Juggernaut.
3625	DEINOS PHAINEIN	FTR	10+	10.9	1888	190	\N	7.0	DIVINE CURSE ⟦呪詛⟧	すずなし	deinosphainein	f	Blacklolita vs Juggernaut.
7283	DEINOS PHAINEIN	INS	12	12	2228	190	\N	7.0	DIVINE WRATH ⟦憤怒⟧	すずなし	deinosphainein	f	Blacklolita vs Juggernaut.
3627	Ember	PST	5	5	740	190	\N	7.0	Fate's End	辷	ember	f	Powerless & siqlo feat. Tia
3628	Ember	PRS	8	8.1	824	190	\N	7.0	Fate's End	辷	ember	f	Powerless & siqlo feat. Tia
3629	Ember	FTR	9+	9.9	1070	190	\N	7.0	Fate's End	辷	ember	f	Powerless & siqlo feat. Tia
7287	⊥⊬	PST	6	6.5	1256	?	\N	7.0	▯	春昼京芒	sacrosanct	f	Silentroom Dismantled XOR かたぎり
7288	⊥⊬	PRS	9	9.6	1385	?	\N	7.0	▯	春昼京芒	sacrosanct	f	Silentroom Dismantled XOR かたぎり
7289	⊥⊬	FTR	10+	10.7	1888	?	\N	7.0	▯	春昼京芒	sacrosanct	f	Silentroom Dismantled XOR かたぎり
\.


--
-- Name: charts_duplicate_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."charts_duplicate_id_seq1"', 7289, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict DhV4zZ46ybKXV04DjvoyMIUvNnjIyrm3lQ0XXFUAIBOS6acijvArx62WrIdS10p

RESET ALL;

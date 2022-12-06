### Poetic books issued between 1830 and 1850

The data stored in the `biblio_poetry_1830_1850.csv` presents harmonised bibliographical data on poetic books issued in Russian Empire between 1830 and 1850. Although most of the bibliographical information is used in the main experiment, this raw data includes various information on the books according to booksellers' and library catalogues.  
  
The main goal of the data collection was to gather books which include lyrical poetry. However, as the research expanded, narrative poems and almanacs were included in the bibliography as well. Nevertheless, the current version of the table does **not** include theatrical pieces in verse (drama) and children books of poetry being very special genres; for the same reason I have not included most of the information on the music sheets and collections of (folk) songs and romances as their bibliography is available in other studies. Lastly, the posthumous poetry collections and translations were also not included in the current bibliography.  
  
#### **Column names and tags**  
##### I. Book description:
**id** -- individual number of each of the entries;  
**poetry_prose** -- variable indicating whether a book is definitely containing prose (`pr`) or rather mostly in verse (`v`);  
**book_type** -- one of the three types of edition: `alm` = almanacs, `col` = collection of either lyrical or narrative poems, `sep`= an edition that includes one or two lyrical or narrative poems;  
**genre** -- lyrical (`lyr`) or narrative (`nar`) genre of poems;  
**special_tag** -- number of tags indicating thematic features of a book, if they were available in catalogues; `unknown` = lost books, `ortho` = orthodox literature; `ukr` = books published in or connected with Ukraine; `double` = indication of the second and consequtive editions of the same book in the table (not filled consequtively at the moment); 
**author_sign** -- the way an author is indicated in the book;  
**author** -- the author(s) revealed by catalogues;  
**author_full_name** -- the full names of authors; 
**title** -- title of the book;  
**city** -- place of publishing;  
**publisher** -- printing house;  
**year** -- year of publishing;  
**pages** -- number of pages;  
**size_fold** -- number of folds;  
**size_cm** -- size of the book in cm;  

##### II. Book appearances in booksellers' catalogues (19th-c.)
These columns includes the book's index number if the book was found in the following catalogues; the columns with the same name as catalogues ending with 'price' appendix are prices indicated in these catalogues (NB except for Kymmel's catalogues these are prices for borrowing the book from the library; the prices cannot be compared directly).
**smirdin_1832** -- Второе прибавление к росписи российским книгам для чтения из библиотеки А. Смирдина. СПб., 1832.
**olhin_46** -- Систематический реестр русским книгам с 1831 по 1846 г. / Изд. М.Д. Ольхина. СПб., 1846.
**krashen_52** -- Третье прибавление к росписи российским книгам для чтения из библиотеки П. Крашенинникова. Продолжение к прежде изданным росписям А. Смирдина. СПб., 1852.
**kymmel_89** -- Антикварный каталог № XXXIX, заключающий в себе перечень книг из библиотеки А. Смирдина, составляющей ныне собственность Н. Киммеля, книгородавца в г. Риге. Отд. IV. Словесность I. Либава: Мейера, 1889.
**kymmel_xxiv** -- Антикварный каталог № XXIV : Bibliotheca Rossica. Коллекция большею частью редких и ценных сочинений на русском языке с начала гражданской печати до новейшего времени, имеющихся в продаже по вставл. при них ценам в кн. магазине и антикв. торговле Н. Киммеля. Рига, 1884.
**MU_1838** -- Список книг библиотеки казенный студентов, императорского Московского Университета. М., 1838.

##### III. Book preservance in modern libraries and special collections
These columns indicate if a printed copy of the book was found in library catalogues. As the Russian National Library was the holder of legal deposits and still contains most of the books of the bibliography, the entries of *RNL* are supplied with ID of the RusMARC cards (the collection of cards is provided as an archive in this repository).  
The search in Russian National Library and Russian State Library was based on the data obtained from the 19th century catalogues, additional entries was added after keyword search; for the rest of the library catalogues the whole collection in Russian language was reviewed de visu. The choice of the libraries were made regarding a) a library holding a special 19th century collection in Russian, b) the library being located in the West provinces of the Russian empire.  
  
**CZ_SLK** -- National Library of the Czech Republic, Slavonic Library (Elektronický katalog Slovanské knihovny) [link](http://www.en.nkp.cz);  total number of entries in Russian between 1830 and 1850: 4222;  
**EE_ester** -- United catalogue of Estonian Libraries [link](https://www.ester.ee/search~S1) (total: 3212);  
**FI_NL** -- National Library of Finland, Slavonic Library [link](https://kansalliskirjasto.finna.fi/?lng=en-gb) (total: 3593);  
**LT_VUL** -- Vilnius University Library [link](https://biblioteka.vu.lt/en/) (total: 4423);
**PL_BUW** -- University of Warsaw Library [link](https://chamo.buw.uw.edu.pl/search/query?theme=system) (total: 827); more info about the Russian collection [Olczak 2015](http://cejsh.icm.edu.pl/cejsh/element/bwmeta1.element.desklight-1375c68f-f651-4976-9698-1f9ce5d5354b/c/Olczak01.pdf);  
**PL_BN** -- National Library of Poland [link](https://www.bn.org.pl) (total: 1450);  
**RNL** -- Russian National Library [link](https://nlr.ru) (total: ~58 thousands);  
**RSL** -- Russian State Library [link](https://www.rsl.ru) (total: ~20 thousands);  
**SPnGU** -- digitized collection of poetic books publised by the Saint Petersburg State University library [link](http://old.library.spbu.ru/dcol/jsp/RcWebBrowse.jsp);  
**US_Harvard** -- Harvard Library, The Kilgour collection of Russian literature 1750-1920 [link](https://hollis.harvard.edu/primo-explore/) (total: 1887); more info about the collection [The Kilgour Catalogue](https://iiif.lib.harvard.edu/manifests/view/drs:49569435$1i);
**Rosanov** -- Printed catalogue of I.N. Rozanov's collection (Библиотека русской поэзии И. Н. Розанова: Библиографическое описание [Государственный музей А.С. Пушкина] / Вступ. статья И.Л. Андроникова. М., 1975);  
**SmSok** -- Smirnov-Sokolsky's almanacs catalogue (Смирнов-Сокольский Н. П. Русские литературные альманахи и сборники XVIII-XIX вв. М., 1965.);  
  
**digital_copy** -- library hosting the digital copy of the book;  
**digital_copy_URL** -- path to the digital copy; if more than one available, others are mentioned in the `Comments` column;  
**Comments** -- notes on the authorship and preservance of the books;
**Censure_permit** -- dates of the censure permit (not filled consequtively yet);  
**Add_censure_data** -- other data related to the book's mentions in censure documents;  
**Comment_Balakin** -- various comments transferred from the bibliography made by A. Balakin for years 1834-1850 [link](https://nexoro.livejournal.com/532415.html).

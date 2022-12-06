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
**EE_ester** -- United catalogue of Estonian Libraries [link]() (total: 3212);  
**FI_NL** -- National Library of Finland, Slavonic Library (total: 3593);  
**LT_VUL** -- Vilnius University Library (total: 4423);
**PL_BUW** -- University of Warsaw Library (total: 827);
**PL_BN** -- National Library of Poland (total: 1450);
**RNL** -- Russian National Library (total: ~58 thousands);
**RSL** -- Russian State Library (total: ~)

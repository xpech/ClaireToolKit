//*********************************************************************
//* WclSite                                        Xavier Pechoultres *
//* monnaie.wcl                                                         *
//* Copyright (C) 2000 - 2003 xl. All Rights Reserved                 *
//*	$Date: 2005-09-27 11:50:47 +0200 (Mar 27 sep 2005) $
//*	$Revision: 1100 $
//*********************************************************************


// *********************************************************************
// *  Table of contents                                                *
// *   Part 1: *                                                       *
// *********************************************************************

curIsoCode	:: Dbo/dbProperty()
curEuroParity	:: Dbo/dbProperty()
curSymbol	:: Dbo/dbProperty()
curName :: Dbo/dbProperty()

WebCurrency <: ephemeral_object(
			dbId:integer,
			curName:string,
			curIsoCode:string,
			curEuroParity:float = 1.0,
			curSymbol:string = "")


[getCurrency(iso_code:string) : (WebCurrency U {unknown})
->	when i := Dbo/dbLoadWhere(USER_DATABASE,WebCurrency,list(tuple(curIsoCode,iso_code)))
	in (if (length(i) > 0) i[1]
		else unknown) else unknown]

[getCurrency(iso_code:{"EUR"}) : WebCurrency
->	WebCurrency( curName = "Euro", curIsoCode = "EUR")]

[getCurrencies() : list[WebCurrency]
->	Dbo/dbLoad(USER_DATABASE,WebCurrency,curIsoCode,true)]

[Dbo/dbStore?(c:{WebCurrency}) : boolean -> true]

[getInfo(self:WebCurrency) : string -> self.curName /+ " (" /+ self.curIsoCode /+ ")" ]

[currency2Euro(c:WebCurrency,val:float) : float
->	val / c.curEuroParity]

[euro2currency(c:WebCurrency,val:float) : float
->	val * c.curEuroParity]

[dbCreate(c:WebCurrency) : boolean
-> try (Dbo/dbCreate(USER_DATABASE,c),
		true)
	catch any (false)]

[dbUpdateParity(iso_code:string,par:float) : void
->	Dbo/dbUpdate(USER_DATABASE,WebCurrency,list(tuple(curEuroParity,par)),list(tuple(curIsoCode,iso_code)))]

[dbUpdateParityAndSymbol(iso_code:string,par:float,sym:string) : void
->	Dbo/dbUpdate(USER_DATABASE,WebCurrency,list(tuple(curEuroParity,par),tuple(curSymbol,sym)),list(tuple(curIsoCode,iso_code)))]


[htmlSelectCurrency(iso_code:string,select_name:string) : void
-> ( ?><select name="<?= select_name ?>"><? ),
	for c in getIsoCurrencies() ( ?>
	<option value="<?= c.curIsoCode ?>" <? (if (iso_code = c.curIsoCode) echo("selected")) ?>><?= getInfo(c) ?></option><? ),
	( ?></select><?)]

[getIsoCurrency(iso_code:string) : (WebCurrency U {unknown})
-> some(c in getIsoCurrencies() | c.curIsoCode = iso_code)]

[getIsoCurrencies() : list[WebCurrency]
->	list(
	WebCurrency( curName = "Afghani AFA",
	 	curIsoCode = "ALL"),
	WebCurrency( curName = "Albanian Lek",
		curIsoCode = "ALL"),
	WebCurrency( curName = "Algerian Dinar",
		curIsoCode = "DZD"),
	WebCurrency( curName = "Andorran Franc",
		curIsoCode = "ADF"),
	WebCurrency( curName = "Andorran Peseta",
		curIsoCode = "ADP"),
	WebCurrency( curName = "Angolan New Kwanza",
		curIsoCode = "AON"),
	WebCurrency( curName = "Argentine Austral",
		curIsoCode = "ARA"),
	WebCurrency( curName = "Argentine Peso",
		curIsoCode = "ARS"),
	WebCurrency( curName = "Aruban Florin (old guilder)",
		curIsoCode = "AWG"),
	WebCurrency( curName = "Australian Dollar",
		curIsoCode = "AUD"),
	WebCurrency( curName = "Bahamian Dollar",
		curIsoCode = "BSD"),
	WebCurrency( curName = "Bahraini Dinar",
		curIsoCode = "BHD"),
	WebCurrency( curName = "Bangladeshi Taka",
		curIsoCode = "BDT"),
	WebCurrency( curName = "Barbados Dollar",
		curIsoCode = "BBD"),
	WebCurrency( curName = "Belize Dollar",
		curIsoCode = "BZD"),
	WebCurrency( curName = "CFA Franc BCEAO",
		curIsoCode = "XOF"),
	WebCurrency( curName = "Bermudian Dollar",
		curIsoCode = "BMD"),
	WebCurrency( curName = "Bhutan Ngultrum",
		curIsoCode = "BTN"),
	WebCurrency( curName = "Bolivian Boliviano",
		curIsoCode = "BOB"),
	WebCurrency( curName = "Botswana Pula",
		curIsoCode = "BWP"),
	WebCurrency( curName = "Brazilian Cruzeiro",
		curIsoCode = "BRC"),
	WebCurrency( curName = "Brazilian Real",
		curIsoCode = "BRL"),
	WebCurrency( curName = "Brunei Dollar",
		curIsoCode = "BND"),
	WebCurrency( curName = "Bulgarian Lev",
		curIsoCode = "BGL"),
	WebCurrency( curName = "Burundi Franc",
		curIsoCode = "BIF"),
	WebCurrency( curName = "Kampuchean (Cambodian) Riel",
		curIsoCode = "KHR"),
	WebCurrency( curName = "Canadian Dollar",
		curIsoCode = "CAD"),
	WebCurrency( curName = "Cape Verde Escudo",
		curIsoCode = "CVE"),
	WebCurrency( curName = "Cayman Islands Dollar",
		curIsoCode = "KYD"),
	WebCurrency( curName = "Chilean Peso",
		curIsoCode = "CLP"),
	WebCurrency( curName = "Chinese Yuan Renminbi",
		curIsoCode = "CNY"),
	WebCurrency( curName = "Colombian Peso",
		curIsoCode = "COP"),
	WebCurrency( curName = "Comoros Franc",
		curIsoCode = "KMF"),
	WebCurrency( curName = "Costa Rican Colon",
		curIsoCode = "CRC"),
	WebCurrency( curName = "Croatian Kuna",
		curIsoCode = "HRK"),
	WebCurrency( curName = "Cuban Peso",
		curIsoCode = "CUP"),
	WebCurrency( curName = "Cyprus Pound",
		curIsoCode = "CYP"),
	WebCurrency( curName = "Czech Koruna",
		curIsoCode = "CZK"),
	WebCurrency( curName = "Danish Krone",
		curIsoCode = "DKK"),
	WebCurrency( curName = "Djibouti Franc",
		curIsoCode = "DJF"),
	WebCurrency( curName = "Dominican Peso",
		curIsoCode = "DOP"),
	WebCurrency( curName = "Dutch Guilder",
		curIsoCode = "NLG"),
	WebCurrency( curName = "Euro",
		curIsoCode = "EUR"),
	WebCurrency( curName = "Ecuador Sucre",
		curIsoCode = "ECS"),
	WebCurrency( curName = "Egyption Pound",
		curIsoCode = "EGP"),
	WebCurrency( curName = "El Salvador Colon",
		curIsoCode = "SVC"),
	WebCurrency( curName = "Estonian Kroon",
		curIsoCode = "EEK"),
	WebCurrency( curName = "Ethiopian Birr",
		curIsoCode = "ETB"),
	WebCurrency( curName = "Falkland Islands Pound",
		curIsoCode = "FKP"),
	WebCurrency( curName = "Fiji Dollar",
		curIsoCode = "FJD"),
	WebCurrency( curName = "Gambian Dalasi",
		curIsoCode = "GMD"),
	WebCurrency( curName = "Ghanaian Cedi",
		curIsoCode = "GHC"),
	WebCurrency( curName = "Gibraltar Pound",
		curIsoCode = "GIP"),
	WebCurrency( curName = "Gold (oz.)",
		curIsoCode = "XAU"),
	WebCurrency( curName = "Guatemalan Quetzal",
		curIsoCode = "GTQ"),
	WebCurrency( curName = "Guiniea Franc",
		curIsoCode = "GNF"),
	WebCurrency( curName = "Guinia-Bissau Peso",
		curIsoCode = "GWP"),
	WebCurrency( curName = "Guyanan Dollar",
		curIsoCode = "GYD"),
	WebCurrency( curName = "Haitian Gourde",
		curIsoCode = "HTG"),
	WebCurrency( curName = "Honduran Lempira",
		curIsoCode = "HNL"),
	WebCurrency( curName = "Hong Kong Dollar",
		curIsoCode = "HKD"),
	WebCurrency( curName = "Hungarian Forint",
		curIsoCode = "HUF"),
	WebCurrency( curName = "Iceland Krona",
		curIsoCode = "ISK"),
	WebCurrency( curName = "Indian Rupee",
		curIsoCode = "INR"),
	WebCurrency( curName = "Indonesian Rupiah",
		curIsoCode = "IDR"),
	WebCurrency( curName = "Iranian Rial",
		curIsoCode = "IRR"),
	WebCurrency( curName = "Iraqi Dinar",
		curIsoCode = "IQD"),
	WebCurrency( curName = "Israeili New Shekel",
		curIsoCode = "ILS"),
	WebCurrency( curName = "Jamaican Dollar",
		curIsoCode = "JMD"),
	WebCurrency( curName = "Japanese Yen",
		curIsoCode = "JPY"),
	WebCurrency( curName = "Jordanian Dinar",
		curIsoCode = "JOD"),
	WebCurrency( curName = "Kazakhstan Tenge",
		curIsoCode = "KZT"),
	WebCurrency( curName = "Kenyan Schilling",
		curIsoCode = "KES"),
	WebCurrency( curName = "Korean Won",
		curIsoCode = "KRW"),
	WebCurrency( curName = "Kuwaiti Dinar",
		curIsoCode = "KWD"),
	WebCurrency( curName = "Lao Kip",
		curIsoCode = "LAK"),
	WebCurrency( curName = "Latvian Lats",
		curIsoCode = "LVL"),
	WebCurrency( curName = "Lebanese Pound",
		curIsoCode = "LBP"),
	WebCurrency( curName = "Lesotho Loti",
		curIsoCode = "LSL"),
	WebCurrency( curName = "Liberian Dollar",
		curIsoCode = "LRD"),
	WebCurrency( curName = "Libyan Dinar",
		curIsoCode = "LYD"),
	WebCurrency( curName = "Lithuanian Litas",
		curIsoCode = "LTL"),
	WebCurrency( curName = "Macau Pataca",
		curIsoCode = "MOP"),
	WebCurrency( curName = "Malagasy Franc",
		curIsoCode = "MGF"),
	WebCurrency( curName = "Malawi Kwacha",
		curIsoCode = "MWK"),
	WebCurrency( curName = "Malaysian Ringgit",
		curIsoCode = "MYR"),
	WebCurrency( curName = "Maldive Rufiyaa",
		curIsoCode = "MVR"),
	WebCurrency( curName = "Maltese Lira",
		curIsoCode = "MTL"),
	WebCurrency( curName = "Mauritanian Ouguiya",
		curIsoCode = "MRO"),
	WebCurrency( curName = "Mauritius Rupee",
		curIsoCode = "MUR"),
	WebCurrency( curName = "Mexican Peso",
		curIsoCode = "MXP"),
	WebCurrency( curName = "Mongolian Tugrik",
		curIsoCode = "MNT"),
	WebCurrency( curName = "Moroccan Dirham",
		curIsoCode = "MAD"),
	WebCurrency( curName = "Mozambique Metical",
		curIsoCode = "MZM"),
	WebCurrency( curName = "Myanmar Kyat",
		curIsoCode = "MMK"),
	WebCurrency( curName = "Netherlands Antillian Guilder",
		curIsoCode = "ANG"),
	WebCurrency( curName = "Namibian Dollar",
		curIsoCode = "NAD"),
	WebCurrency( curName = "Nepalese Rupee",
		curIsoCode = "NPR"),
	WebCurrency( curName = "New Zealand Dollar",
		curIsoCode = "NZD"),
	WebCurrency( curName = "Nicaraguan Cordoba Oro",
		curIsoCode = "NIO"),
	WebCurrency( curName = "Nigerian Naira",
		curIsoCode = "NGN"),
	WebCurrency( curName = "North Korean Won",
		curIsoCode = "KPW"),
	WebCurrency( curName = "Norwegian Kroner",
		curIsoCode = "NOK"),
	WebCurrency( curName = "Omani Rial",
		curIsoCode = "OMR"),
	WebCurrency( curName = "Pakistan Rupee",
		curIsoCode = "PKR"),
	WebCurrency( curName = "Palladium (oz.)",
		curIsoCode = "XPD"),
	WebCurrency( curName = "Panamanian Balboa",
		curIsoCode = "PAB"),
	WebCurrency( curName = "Papua New Guinea Kina",
		curIsoCode = "PGK"),
	WebCurrency( curName = "Paraguay Guarani",
		curIsoCode = "PYG"),
	WebCurrency( curName = "Peruvian Neuevo Sol",
		curIsoCode = "PEN"),
	WebCurrency( curName = "Philippine Peso",
		curIsoCode = "PHP"),
	WebCurrency( curName = "Platinum (oz.)",
		curIsoCode = "XPT"),
	WebCurrency( curName = "Polish Zloty",
		curIsoCode = "PLZ"),
	WebCurrency( curName = "Qatari Rial",
		curIsoCode = "QAR"),
	WebCurrency( curName = "Romanian Leu",
		curIsoCode = "ROL"),
	WebCurrency( curName = "Russian Rouble",
		curIsoCode = "RUB"),
	WebCurrency( curName = "Samoan Tala",
		curIsoCode = "WST"),
	WebCurrency( curName = "Sao Tome and Principe Dobra",
		curIsoCode = "STD"),
	WebCurrency( curName = "Saudi Riyal",
		curIsoCode = "SAR"),
	WebCurrency( curName = "Seychelles Rupee",
		curIsoCode = "SCR"),
	WebCurrency( curName = "Sierra Leone Leone",
		curIsoCode = "SLL"),
	WebCurrency( curName = "Silver (oz.)",
		curIsoCode = "XAG"),
	WebCurrency( curName = "Singapore Dollar",
		curIsoCode = "SGD"),
	WebCurrency( curName = "Slovak Koruna",
		curIsoCode = "SKK"),
	WebCurrency( curName = "Slovenian Tolar",
		curIsoCode = "SIT"),
	WebCurrency( curName = "Solomon Islands Dollar",
		curIsoCode = "SBD"),
	WebCurrency( curName = "Somali Schilling",
		curIsoCode = "SOS"),
	WebCurrency( curName = "South African Rand",
		curIsoCode = "ZAR"),
	WebCurrency( curName = "Sri Lanka Rupee",
		curIsoCode = "LKR"),
	WebCurrency( curName = "St. Helena Pound",
		curIsoCode = "SHP"),
	WebCurrency( curName = "Sudanese Dinar",
		curIsoCode = "SDD"),
	WebCurrency( curName = "Sudanese Pound",
		curIsoCode = "SDP"),
	WebCurrency( curName = "Suriname Guilder",
		curIsoCode = "SRG"),
	WebCurrency( curName = "Swaziland Lilangeni",
		curIsoCode = "SZL"),
	WebCurrency( curName = "Swedish Krona",
		curIsoCode = "SEK"),
	WebCurrency( curName = "Swiss Franc",
		curIsoCode = "CHF"),
	WebCurrency( curName = "Syrian Pound",
		curIsoCode = "SYP"),
	WebCurrency( curName = "Taiwan Dollar",
		curIsoCode = "TWD"),
	WebCurrency( curName = "Tanzanian Schilling",
		curIsoCode = "TZS"),
	WebCurrency( curName = "Thai Baht",
		curIsoCode = "THB"),
	WebCurrency( curName = "Tongan Pa'anga",
		curIsoCode = "TOP"),
	WebCurrency( curName = "Trinidad and Tobago Dollar",
		curIsoCode = "TTD"),
	WebCurrency( curName = "Tunisian Dinar",
		curIsoCode = "TND"),
	WebCurrency( curName = "Turkish Lira",
		curIsoCode = "TRL"),
	WebCurrency( curName = "US Dollar",
		curIsoCode = "USD"),
	WebCurrency( curName = "Uganda Schilling",
		curIsoCode = "UGS"),
	WebCurrency( curName = "Ukraine Hryvnia",
		curIsoCode = "UAG"),
	WebCurrency( curName = "Ukraine Karbovanets",
		curIsoCode = "UAK"),
	WebCurrency( curName = "United Kingdom Pound",
		curIsoCode = "GBP"),
	WebCurrency( curName = "Uruguayan Peso",
		curIsoCode = "UYP"),
	WebCurrency( curName = "United Arab Emirates Dirham",
		curIsoCode = "AED"),
	WebCurrency( curName = "Vanuatu Vatu",
		curIsoCode = "VUV"),
	WebCurrency( curName = "Venezuelan Bolivar",
		curIsoCode = "VEB"),
	WebCurrency( curName = "Vietnamese Dong",
		curIsoCode = "VND"),
	WebCurrency( curName = "Yugoslav Dinar",
		curIsoCode = "YUN"),
	WebCurrency( curName = "Zambian Kwacha",
		curIsoCode = "ZMK"),
	WebCurrency( curName = "Zimbabwe Dollar",
		curIsoCode = "ZWD"))]

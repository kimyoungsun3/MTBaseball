﻿<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="common.util.DbUtil"%>
<%@ page import="formutil.FormUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ page import="org.json.simple.*"%>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="util" class="formutil.FormUtil" />
<%@include file="_define.jsp"%>
<%@include file="_checkfun.jsp"%> 

<%!
	/*
	ikind	: googlekw
	ucode	: 12999763169054705758.1323631300639409
	idata	:
	idata2	: {"receipt":{"orderId":"12999763169054705758.1323631300639409","packageName":"com.sangsangdigital.mokjanggg","productId":"farm_9900","purchaseTime":1383720381901,"purchaseState":0,"developerPayload":"optimus","purchaseToken":"zmjsgzkhoqngotpchnghpmql.AO-J1Oym516yHp58m15m_oBuGauSWSDajCx5zYnlBmVXjH8lHDv2X-ZXRDE7cuZV9UdZ82VPgDw795V6jVYSV4mmJpJ3y1pxoUXACa-5uAto9CeCBTYzePTPcrbIK4jUdP_592FNuE3I"}, "status":0}

	ikind	: sandbox
	ucode	: 1000000103970175
	idata	: ewoJInNpZ25hdHVyZSIgPSAiQWlvN0RIQ0N4V0o3NURUOE1zS1ljQ3kwbWhIS3pr  N2RoU1lPWEJWN0hBRlE5anNZWHdIekZudGxMSmhPeW1DNUFObU9mb0FaUGQvaVhI  UzNVdFpsblhvcjViU0c2aG5JSk0wMitBeHYvd3NabGwyMTNCeW1SNUlHOG9UaC9L  dlZrZ2ExQXFubTNaeDAxYXZIa2s5Qk9lRUNiUENOSTlVNGZaMmc4V2U3bXhsM0FB  QURWekNDQTFNd2dnSTdvQU1DQVFJQ0NHVVVrVTNaV0FTMU1BMEdDU3FHU0liM0RR  RUJCUVVBTUg4eEN6QUpCZ05WQkFZVEFsVlRNUk13RVFZRFZRUUtEQXBCY0hCc1pT  QkpibU11TVNZd0pBWURWUVFMREIxQmNIQnNaU0JEWlhKMGFXWnBZMkYwYVc5dUlF  RjFkR2h2Y21sMGVURXpNREVHQTFVRUF3d3FRWEJ3YkdVZ2FWUjFibVZ6SUZOMGIz  SmxJRU5sY25ScFptbGpZWFJwYjI0Z1FYVjBhRzl5YVhSNU1CNFhEVEE1TURZeE5U  SXlNRFUxTmxvWERURTBNRFl4TkRJeU1EVTFObG93WkRFak1DRUdBMVVFQXd3YVVI  VnlZMmhoYzJWU1pXTmxhWEIwUTJWeWRHbG1hV05oZEdVeEd6QVpCZ05WQkFzTUVr  RndjR3hsSUdsVWRXNWxjeUJUZEc5eVpURVRNQkVHQTFVRUNnd0tRWEJ3YkdVZ1NX  NWpMakVMTUFrR0ExVUVCaE1DVlZNd2daOHdEUVlKS29aSWh2Y05BUUVCQlFBRGdZ  MEFNSUdKQW9HQkFNclJqRjJjdDRJclNkaVRDaGFJMGc4cHd2L2NtSHM4cC9Sd1Yv  cnQvOTFYS1ZoTmw0WElCaW1LalFRTmZnSHNEczZ5anUrK0RyS0pFN3VLc3BoTWRk  S1lmRkU1ckdYc0FkQkVqQndSSXhleFRldngzSExFRkdBdDFtb0t4NTA5ZGh4dGlJ  ZERnSnYyWWFWczQ5QjB1SnZOZHk2U01xTk5MSHNETHpEUzlvWkhBZ01CQUFHamNq  QndNQXdHQTFVZEV3RUIvd1FDTUFBd0h3WURWUjBqQkJnd0ZvQVVOaDNvNHAyQzBn  RVl0VEpyRHRkREM1RllRem93RGdZRFZSMFBBUUgvQkFRREFnZUFNQjBHQTFVZERn  UVdCQlNwZzRQeUdVakZQaEpYQ0JUTXphTittVjhrOVRBUUJnb3Foa2lHOTJOa0Jn  VUJCQUlGQURBTkJna3Foa2lHOXcwQkFRVUZBQU9DQVFFQUVhU2JQanRtTjRDL0lC  M1FFcEszMlJ4YWNDRFhkVlhBZVZSZVM1RmFaeGMrdDg4cFFQOTNCaUF4dmRXLzNl  VFNNR1k1RmJlQVlMM2V0cVA1Z204d3JGb2pYMGlreVZSU3RRKy9BUTBLRWp0cUIw  N2tMczlRVWU4Y3pSOFVHZmRNMUV1bVYvVWd2RGQ0TndOWXhMUU1nNFdUUWZna1FR  Vnk4R1had1ZIZ2JFL1VDNlk3MDUzcEdYQms1MU5QTTN3b3hoZDNnU1JMdlhqK2xv  SHNTdGNURXFlOXBCRHBtRzUrc2s0dHcrR0szR01lRU41LytlMVFUOW5wL0tsMW5q  K2FCdzdDMHhzeTBiRm5hQWQxY1NTNnhkb3J5L0NVdk02Z3RLc21uT09kcVRlc2Jw  MGJzOHNuNldxczBDOWRnY3hSSHVPTVoydG04bnBMVW03YXJnT1N6UT09IjsKCSJw  dXJjaGFzZS1pbmZvIiA9ICJld29KSW05eWFXZHBibUZzTFhCMWNtTm9ZWE5sTFdS  aGRHVXRjSE4wSWlBOUlDSXlNREV6TFRBMkxURXlJREF4T2pNeU9qSTNJRUZ0WlhK  cFkyRXZURzl6WDBGdVoyVnNaWE1pT3dvSkluVnVhWEYxWlMxcFpHVnVkR2xtYVdW  eUlpQTlJQ0l3WVdNM05UUXpZMkppWkRRM1lqRmhPVGRsTTJaaFpEY3pNamt4WWpB  eU1UTm1ZelV4TldOaUlqc0tDU0p2Y21sbmFXNWhiQzEwY21GdWMyRmpkR2x2Ymkx  cFpDSWdQU0FpTVRBd01EQXdNREEzTnpBeU1ETTNOeUk3Q2draVluWnljeUlnUFNB  aU1TNHhMallpT3dvSkluUnlZVzV6WVdOMGFXOXVMV2xrSWlBOUlDSXhNREF3TURB  d01EYzNNREl3TXpjM0lqc0tDU0p4ZFdGdWRHbDBlU0lnUFNBaU1TSTdDZ2tpYjNK  cFoybHVZV3d0Y0hWeVkyaGhjMlV0WkdGMFpTMXRjeUlnUFNBaU1UTTNNVEF5TlRr  ME56VTRPU0k3Q2draWRXNXBjWFZsTFhabGJtUnZjaTFwWkdWdWRHbG1hV1Z5SWlB  OUlDSkZOVVV6UlVNeU5TMDFSVVpGTFRRd09UTXRPREV4UlMwNFFVWTFNRGM1UlRr  M05FVWlPd29KSW5CeWIyUjFZM1F0YVdRaUlEMGdJbWh2YldWeWRXNW5iMnhrWHpF  MUlqc0tDU0pwZEdWdExXbGtJaUE5SUNJMk16ZzJOVGMwTnpBaU93b0pJbUpwWkNJ  Z1BTQWljMkZ1WjNOaGJtZGthV2RwZEdGc0xtTnZiUzVvYjIxbGNuVnViR1ZoWjNW  bElqc0tDU0p3ZFhKamFHRnpaUzFrWVhSbExXMXpJaUE5SUNJeE16Y3hNREkxT1RR  M05UZzVJanNLQ1NKd2RYSmphR0Z6WlMxa1lYUmxJaUE5SUNJeU1ERXpMVEEyTFRF  eUlEQTRPak15T2pJM0lFVjBZeTlIVFZRaU93b0pJbkIxY21Ob1lYTmxMV1JoZEdV  dGNITjBJaUE5SUNJeU1ERXpMVEEyTFRFeUlEQXhPak15T2pJM0lFRnRaWEpwWTJF  dlRHOXpYMEZ1WjJWc1pYTWlPd29KSW05eWFXZHBibUZzTFhCMWNtTm9ZWE5sTFdS  aGRHVWlJRDBnSWpJd01UTXRNRFl0TVRJZ01EZzZNekk2TWpjZ1JYUmpMMGROVkNJ  N0NuMD0iOwoJImVudmlyb25tZW50IiA9ICJTYW5kYm94IjsKCSJwb2QiID0gIjEw  MCI7Cgkic2lnbmluZy1zdGF0dXMiID0gIjAiOwp9
	idata2	: {"receipt":{"original_purchase_date_pst":"2013-06-12 01:32:27 America/Los_Angeles", "purchase_date_ms":"1371025947589", "unique_identifier":"0ac7543cbbd47b1a97e3fad73291b0213fc515cb", "original_transaction_id":"1000000077020377", "bvrs":"1.1.6", "transaction_id":"1000000077020377", "quantity":"1", "unique_vendor_identifier":"E5E3EC25-5EFE-4093-811E-8AF5079E974E", "item_id":"638657470", "product_id":"homerungold_15", "purchase_date":"2013-06-12 08:32:27 Etc/GMT", "original_purchase_date":"2013-06-12 08:32:27 Etc/GMT", "purchase_date_pst":"2013-06-12 01:32:27 America/Los_Angeles", "bid":"sangsangdigital.com.homerunleague", "original_purchase_date_ms":"1371025947589"}, "status":0}

	ikind	: skt
	ucode	: TX_00000000091709
	idata	: "{\"signdata\":\"MIIH+gYJKoZIhvcNAQcCoIIH6zCCB+cCAQExDzANBglghkgBZQMEAgEFADBZBgkqhkiG9w0BBwGgTARKMjAxMzEyMDExNzEyNDd8VFhfMDAwMDAwMDAwOTE3MDl8MDEwNDY4MDMwNjZ8T0EwMDY0NjU0NnwwOTEwMDA0MzA4fDIwMDB8fHygggXvMIIF6zCCBNOgAwIBAgIDT7hrMA0GCSqGSIb3DQEBCwUAME8xCzAJBgNVBAYTAktSMRIwEAYDVQQKDAlDcm9zc0NlcnQxFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEVMBMGA1UEAwwMQ3Jvc3NDZXJ0Q0EyMB4XDTEyMTIyMTA0MjcwMFoXDTEzMTIyMTE0NTk1OVowgYwxCzAJBgNVBAYTAktSMRIwEAYDVQQKDAlDcm9zc0NlcnQxFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEbMBkGA1UECwwS7ZWc6rWt7KCE7J6Q7J247KadMQ8wDQYDVQQLDAbshJzrsoQxJDAiBgNVBAMMG+yXkOyKpOy8gOydtCDtlIzrnpjri5so7KO8KTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMy0j+0TIEctoIbhJp8MD+DFWwas3ejmfasmZ2jXW44y2wHWWHX4UfOVzM9GJMYdjp5BVOgGylTk32dsysjxzQLtChKIJydSfvgrNisfSndzijxxi8yE9CZoe\\/BL+Czgxyq29oEIxUp8izXrrOEaOb\\/9Vd5QbIsK7auGu6CdiN5H+naKAoCcrptQikcSyvuUKrqTEvgIQtpnLIAxHUq5Yd0RBU\\/OW7ToY4I703xhre3arQRaRoeXfUwKQv0zQEUTVkDyS\\/dT0KYETFbWhmSC689\\/t6Odccml9+S98peqxqs7jxYpiT1gOg8EF0HgBW+yy2jWgSfirYvj4DHf7z50kfECAwEAAaOCApAwggKMMIGPBgNVHSMEgYcwgYSAFLZ0qZuSPMdRsSKkT7y3PP4iM9d2oWikZjBkMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEWMBQGA1UEAwwNS0lTQSBSb290Q0EgNIICEAQwHQYDVR0OBBYEFBdwpU\\/Z\\/kva797rgtl+huf9m0ooMA4GA1UdDwEB\\/wQEAwIGwDCBgwYDVR0gAQH\\/BHkwdzB1BgoqgxqMmkQFBAEDMGcwLQYIKwYBBQUHAgEWIWh0dHA6Ly9nY2EuY3Jvc3NjZXJ0LmNvbS9jcHMuaHRtbDA2BggrBgEFBQcCAjAqHii8+AAgx3jJncEcx1gAIMcg1qiuMKwEx0AAIAAxsUQAIMeFssiy5AAuMHoGA1UdEQRzMHGgbwYJKoMajJpECgEBoGIwYAwb7JeQ7Iqk7LyA7J20IO2UjOuemOuLmyjso7wpMEEwPwYKKoMajJpECgEBATAxMAsGCWCGSAFlAwQCAaAiBCDnstgCMlYs4YsIkS3E0PdeGKoWB93Wgpowj0jLuQQfEjB\\/BgNVHR8EeDB2MHSgcqBwhm5sZGFwOi8vZGlyLmNyb3NzY2VydC5jb206Mzg5L2NuPXMxZHA2cDExMDYsb3U9Y3JsZHAsb3U9QWNjcmVkaXRlZENBLG89Q3Jvc3NDZXJ0LGM9S1I\\/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDBGBggrBgEFBQcBAQQ6MDgwNgYIKwYBBQUHMAGGKmh0dHA6Ly9vY3NwLmNyb3NzY2VydC5jb206MTQyMDMvT0NTUFNlcnZlcjANBgkqhkiG9w0BAQsFAAOCAQEAjmfND0w8NuggOa9qxt6vGWHyU4YcZBhNJ88AVxnIYeOP+vFO7y2kTguEF+yDV+x+a+Fxc54icRNBi4iwq8xF9C2\\/H6yLAR3YBKLZS+1QdYXtpTp4vnlBuugFNR8FtLni4R3rFfqXf+96V7liApgPVYU31go5YIWJYBJoiXz8\\/mXD3ZNCV8kOOqDtf\\/VFwO1vn8nqCnPCzoe9Sq2dm1+TaRsJD9NTf4E9z4xoPjdz\\/6q97X3D3kcIgUH6jYi\\/hwsGBgqYyKuT4+WImqJilWPjlDFMYI+RVsdiSL1tg4atYnsW6KGoAEk3ve46W04nCZzM3fVvDu4rzsV7zZ1SZ4rbxjGCAYEwggF9AgEBMFYwTzELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRUwEwYDVQQDDAxDcm9zc0NlcnRDQTICA0+4azANBglghkgBZQMEAgEFADANBgkqhkiG9w0BAQsFAASCAQCjeaxPvidtQuIV0skqPo4z+PWNKhLCvtskVQRvAIGnvmieCfnP+pOmLrv4VxrD9yeRbG7GfEGRD\\/W66z\\/0+tD6ku8gFYwRMzsXYVYenIiqJtG2havqMHCyGKxhxqdKYkcDwwTTzdRRmzAo2x\\/FWYV1HMQjqYiQntHeSC\\/5I3mGnATCF3ijvKWIUOc0HA59\\/fuWrut2oSAi5nw8IAvzUOMHaA\\/7f7XzHVGd5vV0sMJ1qYL29TA+EdozYh7Y\\/2usNVLZqJ\\/5yz9lbAuQ8ScYu3GIKiAdjQDASy\\/fqngZfz6Tj8PPx4t3PRz3ZXJsH+ZRdPh2ju3+gFUcFWQvOg\\/UP+v1\",\"txid\":\"TX_00000000091709\",\"appid\":\"OA00646546\"}";
	idata2	: {"product":[{"appid":"OA00646546","bp_info":"","charge_amount":2000,"detail_pname":"",            "log_time":"20131201171247","product_id":"0910004308","tid":""}],"message":"정상검증완료.",   "detail":"0000","count":1,"status":0}
	    _data:{"product":[{"appid":"OA00700316","bp_info":"","charge_amount":3300,"detail_pname":"猷⑤퉬 310媛?,"log_time":"20160518173754","product_id":"0910047079","tid":""}],"message":"?뺤긽寃?쬆?꾨즺.","detail":"0000","count":1,"status":0}
	*/



	////////////////////////////////////////
	//SKT 인증하기
	////////////////////////////////////////
	public String callSKTSite(String _strIKind, String _strParam){
		//1-1. 네트워크 정의
		String SKT_URL_TEST 	= "https://iapdev.tstore.co.kr/digitalsignconfirm.iap";
		String SKT_URL_REAL 	= "https://iap.tstore.co.kr/digitalsignconfirm.iap";
		String SKT_REAL			= "real";
		String _strURL;
		StringBuilder sb = new StringBuilder("");

		///////////////////////////////////////////
		// "	-> \"
		//	\	-> \\
		//_strParam = "{\"signdata\":\"M\"}";
		//_strParam = "{\"signdata\":\"M\",\"txid\":\"TX_00000000091701\",\"appid\":\"OA00646546\"}";
		///////////////////////////////////////////
		//	[원본]	> [디코딩]
		///////////////////////////////////////////
		//"{\"signdata\":\"MIIH+gYJKoZIhvcNAQcCoIIH6zCCB+cCAQExDzANBglghkgBZQMEAgEFADBZBgkqhkiG9w0BBwGgTARKMjAxMzEyMDExNzEyNDd8VFhfMDAwMDAwMDAwOTE3MDl8MDEwNDY4MDMwNjZ8T0EwMDY0NjU0NnwwOTEwMDA0MzA4fDIwMDB8fHygggXvMIIF6zCCBNOgAwIBAgIDT7hrMA0GCSqGSIb3DQEBCwUAME8xCzAJBgNVBAYTAktSMRIwEAYDVQQKDAlDcm9zc0NlcnQxFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEVMBMGA1UEAwwMQ3Jvc3NDZXJ0Q0EyMB4XDTEyMTIyMTA0MjcwMFoXDTEzMTIyMTE0NTk1OVowgYwxCzAJBgNVBAYTAktSMRIwEAYDVQQKDAlDcm9zc0NlcnQxFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEbMBkGA1UECwwS7ZWc6rWt7KCE7J6Q7J247KadMQ8wDQYDVQQLDAbshJzrsoQxJDAiBgNVBAMMG+yXkOyKpOy8gOydtCDtlIzrnpjri5so7KO8KTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMy0j+0TIEctoIbhJp8MD+DFWwas3ejmfasmZ2jXW44y2wHWWHX4UfOVzM9GJMYdjp5BVOgGylTk32dsysjxzQLtChKIJydSfvgrNisfSndzijxxi8yE9CZoe\\/BL+Czgxyq29oEIxUp8izXrrOEaOb\\/9Vd5QbIsK7auGu6CdiN5H+naKAoCcrptQikcSyvuUKrqTEvgIQtpnLIAxHUq5Yd0RBU\\/OW7ToY4I703xhre3arQRaRoeXfUwKQv0zQEUTVkDyS\\/dT0KYETFbWhmSC689\\/t6Odccml9+S98peqxqs7jxYpiT1gOg8EF0HgBW+yy2jWgSfirYvj4DHf7z50kfECAwEAAaOCApAwggKMMIGPBgNVHSMEgYcwgYSAFLZ0qZuSPMdRsSKkT7y3PP4iM9d2oWikZjBkMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEWMBQGA1UEAwwNS0lTQSBSb290Q0EgNIICEAQwHQYDVR0OBBYEFBdwpU\\/Z\\/kva797rgtl+huf9m0ooMA4GA1UdDwEB\\/wQEAwIGwDCBgwYDVR0gAQH\\/BHkwdzB1BgoqgxqMmkQFBAEDMGcwLQYIKwYBBQUHAgEWIWh0dHA6Ly9nY2EuY3Jvc3NjZXJ0LmNvbS9jcHMuaHRtbDA2BggrBgEFBQcCAjAqHii8+AAgx3jJncEcx1gAIMcg1qiuMKwEx0AAIAAxsUQAIMeFssiy5AAuMHoGA1UdEQRzMHGgbwYJKoMajJpECgEBoGIwYAwb7JeQ7Iqk7LyA7J20IO2UjOuemOuLmyjso7wpMEEwPwYKKoMajJpECgEBATAxMAsGCWCGSAFlAwQCAaAiBCDnstgCMlYs4YsIkS3E0PdeGKoWB93Wgpowj0jLuQQfEjB\\/BgNVHR8EeDB2MHSgcqBwhm5sZGFwOi8vZGlyLmNyb3NzY2VydC5jb206Mzg5L2NuPXMxZHA2cDExMDYsb3U9Y3JsZHAsb3U9QWNjcmVkaXRlZENBLG89Q3Jvc3NDZXJ0LGM9S1I\\/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDBGBggrBgEFBQcBAQQ6MDgwNgYIKwYBBQUHMAGGKmh0dHA6Ly9vY3NwLmNyb3NzY2VydC5jb206MTQyMDMvT0NTUFNlcnZlcjANBgkqhkiG9w0BAQsFAAOCAQEAjmfND0w8NuggOa9qxt6vGWHyU4YcZBhNJ88AVxnIYeOP+vFO7y2kTguEF+yDV+x+a+Fxc54icRNBi4iwq8xF9C2\\/H6yLAR3YBKLZS+1QdYXtpTp4vnlBuugFNR8FtLni4R3rFfqXf+96V7liApgPVYU31go5YIWJYBJoiXz8\\/mXD3ZNCV8kOOqDtf\\/VFwO1vn8nqCnPCzoe9Sq2dm1+TaRsJD9NTf4E9z4xoPjdz\\/6q97X3D3kcIgUH6jYi\\/hwsGBgqYyKuT4+WImqJilWPjlDFMYI+RVsdiSL1tg4atYnsW6KGoAEk3ve46W04nCZzM3fVvDu4rzsV7zZ1SZ4rbxjGCAYEwggF9AgEBMFYwTzELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRUwEwYDVQQDDAxDcm9zc0NlcnRDQTICA0+4azANBglghkgBZQMEAgEFADANBgkqhkiG9w0BAQsFAASCAQCjeaxPvidtQuIV0skqPo4z+PWNKhLCvtskVQRvAIGnvmieCfnP+pOmLrv4VxrD9yeRbG7GfEGRD\\/W66z\\/0+tD6ku8gFYwRMzsXYVYenIiqJtG2havqMHCyGKxhxqdKYkcDwwTTzdRRmzAo2x\\/FWYV1HMQjqYiQntHeSC\\/5I3mGnATCF3ijvKWIUOc0HA59\\/fuWrut2oSAi5nw8IAvzUOMHaA\\/7f7XzHVGd5vV0sMJ1qYL29TA+EdozYh7Y\\/2usNVLZqJ\\/5yz9lbAuQ8ScYu3GIKiAdjQDASy\\/fqngZfz6Tj8PPx4t3PRz3ZXJsH+ZRdPh2ju3+gFUcFWQvOg\\/UP+v1\",\"txid\":\"TX_00000000091709\",\"appid\":\"OA00646546\"}";
		//{"product":[{"appid":"OA00646546","bp_info":"","charge_amount":2000,"detail_pname":"","log_time":"20131201171247","product_id":"0910004308","tid":""}],"message":"정상검증완료.","detail":"0000","count":1,"status":0}

		//1-2. 변수 전의
		URL url;
		URLConnection conn;
		HttpURLConnection  hurlc;
		InputStream is;
		InputStreamReader isr;
		BufferedReader br;
		PrintWriter out;
		String line;

		//2-1. 분류하기
		if(_strIKind.equalsIgnoreCase(SKT_REAL)){
			_strURL = SKT_URL_REAL;
		}else{
			_strURL = SKT_URL_TEST;
		}

		//Apple에서 검사해서오기
		try{
			//URL객체를 생성하고 해당 URL로 접속한다.
			url = new URL(_strURL);
			conn = url.openConnection();
			hurlc = (HttpURLConnection )conn;

			hurlc.setRequestProperty("Content-Type", "application/json");
			hurlc.setRequestMethod("POST");
			hurlc.setConnectTimeout(30 * 1000);
			hurlc.setDoOutput(true);
			hurlc.setDoInput(true);
			hurlc.setDefaultUseCaches(false);
			hurlc.setUseCaches(false);

			out = new PrintWriter(hurlc.getOutputStream());
			out.print(_strParam);
			out.close();

			//내용을 읽어오기위한 InputStream객체를 생성한다..
			is = hurlc.getInputStream();
			isr = new InputStreamReader(is, "UTF-8");
			br = new BufferedReader(isr);
			//내용을 읽어서 화면에 출력한다..
			while((line = br.readLine()) != null){
				sb.append(line);
			}

			//연결종료
			if(br != null)br.close();
			if(isr != null)isr.close();
			if(is != null)is.close();
			if(hurlc != null)hurlc.disconnect();
		}catch(Exception e){
			sb.append("error");
		}
	    return sb.toString();
	}

	////////////////////////////////////////
	//SKT 인증하기 > 데이타 파싱해서 검사
	////////////////////////////////////////
	public boolean getSKTSuccess(String _data, int _money, String _aids[], int _moneys[], String _pids[]){
		String _status = null, _detail = null, _appid = null, _charge_amount = null, _product_id = null;
		int _len;
		int _money2;
		boolean _debug		= false;
		boolean _bStatus 	= false;
		boolean _bDetail 	= false;
		boolean _bMoney 	= false;
		boolean _bMoney2 	= false;
		boolean _baid 		= false;
		boolean _bpid 		= false;

		String _strRetrun = "";

		try{
			//{"product":[{"appid":"OA00700316","bp_info":"","charge_amount":3300,"detail_pname":"루비 310개","log_time":"20160518173458","product_id":"0910047079","tid":""}],"message":"정상검증완료.","detail":"0000","count":1,"status":0}
			//
			//{
			//	"product":[
			//		{
			//		"appid":"OA00700316",
			//		"bp_info":"",
			//		"charge_amount":3300,
			//		"detail_pname":"루비 310개",
			//		"log_time":"20160518173458",
			//		"product_id":"0910047079",
			//		"tid":""
			//		}
			//	],
			//	"message":"정상검증완료.",
			//	"detail":"0000",
			//	"count":1,
			//	"status":0
			//}

			Object _obj = JSONValue.parse( _data );
			JSONObject _object = (JSONObject) _obj;
			JSONArray _product = (JSONArray) _object.get("product");

			if(_debug){
				System.out.println("strc:" + _data);
				System.out.println("detmessageail:" + _object.get("message").toString());
				System.out.println("detail:" 		+ _object.get("detail").toString());
				System.out.println("count:"			+ _object.get("count").toString());
				System.out.println("status:" 		+ _object.get("status").toString());
				for (Object jobj : _product.toArray()) {
					System.out.println("appid:" + ((JSONObject) jobj).get("appid").toString());
					System.out.println("product_id:" + ((JSONObject) jobj).get("product_id").toString());
				}
			}

			_status = _object.get("status").toString();
			if(_status != null && _status.equals("0")){
				_bStatus = true;
			}

			_detail = _object.get("detail").toString();
			if(_detail != null && _detail.equals("0000")){
				_bDetail = true;
			}

			for (Object jobj : _product.toArray()) {
				_appid 			= ((JSONObject) jobj).get("appid").toString();
				_charge_amount 	= ((JSONObject) jobj).get("charge_amount").toString();
				_product_id 	= ((JSONObject) jobj).get("product_id").toString();
			}

			if(_charge_amount == null || _charge_amount.equals("")){
				_money2 = -9999;
			}else{
				_money2 = Integer.parseInt(_charge_amount);
			}

			if(_money == _money2){
				_bMoney = true;
			}

			_len = _moneys.length;
			for(int i = 0; i < _len; i++){
				if(_money == _moneys[i]){
					_bMoney2 = true;
					break;
				}
			}

			_len = _aids.length;
			if(_appid != null){
				for(int i = 0; i < _len; i++){
					if(_appid.equalsIgnoreCase(_aids[i])){
						_baid = true;
						break;
					}
				}
			}

			_len = _pids.length;
			if(_product_id != null){
				for(int i = 0; i < _len; i++){
					if(_product_id.equalsIgnoreCase(_pids[i])){
						_bpid = true;
						break;
					}
				}
			}
		}catch(Exception e){
			//_strRetrun += "e:" + e;
			//System.out.println("e:" + e);
		}

		//_strRetrun = _bStatus +":"+ _bDetail +":"+ _bMoney +":"+ _bMoney2 +":"+ _baid +":"+ _bpid;
		//return _strRetrun;
		return (_bStatus && _bDetail && _bMoney && _bMoney2 && _baid && _bpid);

	}

	public String getSKTtxid(String _data){
		String _str;
		String _strRetrun = "";

		try{
			Object _obj2 = JSONValue.parse("[0, " + _data + "]");	//[0, xx] <= 꼭 넣어줘야하네 ㅠㅠ.
			JSONArray _array = (JSONArray)_obj2;
			JSONObject _obj3 = (JSONObject)_array.get(1);

			_strRetrun = _obj3.get("txid").toString();

		}catch(Exception e){
			//_strRetrun += "e:" + e;
		}

		return _strRetrun;
	}
%>

<%
	//1. 생성자 위치
	Connection conn				= DbUtil.getConnection();
	CallableStatement cstmt	 	= null;
	ResultSet result 			= null;
	StringBuffer query 			= new StringBuffer();
	StringBuffer msg 			= new StringBuffer();
	int resultCode				= -1;
	StringBuffer resultMsg		= new StringBuffer();
	int idxColumn				= 1;
	boolean DEBUG				= true;


	/////////////////////////////////////////////////////////
	//	SKT
	/////////////////////////////////////////////////////////
	String strSKTAIDList[] = {
						"OA00646546",					//야구.
						"OA00652027",					//목장.
						"OA00700316"					//K5
	};
	int nSKTMoneyList[] = {							//가격
						3300,
						5500,
						11000,
						33000,
						55000,
						110000
	};
	String strSKTPIDList[] = {
						//상상					픽토
						"0910047079", 			"0910007674",
						"0910047080",  			"0910007676",
						"0910047081",  			"0910007677",
						"0910047082",  			"0910007678",
						"0910047083",  			"0910007679",
						"0910047084",  			"0910007680"
	};


	String ikind		= util.getParamStr(request, "ikind", "");	//SKT SandBox or Real
	String idata		= "";										//영수증 전문(3k)
	String idata2		= "";
	int summary, market, cash;

	///////////////////////////////////////////////////
	ikind	= "debug1";
	idata 	= "{\"appid\":\"OA00700316\",\"txid\":\"TX_00000000336707\",\"signdata\":\"MIIIBAYJKoZIhvcNAQcCoIIH9TCCB\\/ECAQExDzANBglghkgBZQMEAgEFADBjBgkqhkiG9w0BBwGgVgRUMjAxNjA1MTgxNzM0NTh8VFhfMDAwMDAwMDAzMzY3MDd8MDEwMzI0ODMxNDR8T0EwMDcwMDMxNnwwOTEwMDQ3MDc5fDMzMDB8fHy357rxIDMxMLCzoIIF7jCCBeowggTSoAMCAQICBAEDYIQwDQYJKoZIhvcNAQELBQAwTzELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRUwEwYDVQQDDAxDcm9zc0NlcnRDQTIwHhcNMTUxMjE2MDUyMzAwWhcNMTYxMjIxMTQ1OTU5WjCBjDELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRswGQYDVQQLDBLtlZzqta3soITsnpDsnbjspp0xDzANBgNVBAsMBuyEnOuyhDEkMCIGA1UEAwwb7JeQ7Iqk7LyA7J20IO2UjOuemOuLmyjso7wpMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0Ldr5ayjfKQiow61No6GPTX3M7ooj+IoZ18eN+KDRk7CJjLP+rg6pUZja0bDhwIxjLgeUo5ohJAndCbRwapXRgfegbO5B89dIBhy5qxHpnIPg8pSgyl9YdmBH0OinEJLesv5P0jieLH6FeoRhSRecJZpQXR3XtYMB2pltB4\\/yA6NCN946ytbEU5aRzLYZtqcZ6ubtkZnGW63ZLXR9gc0lhFS07h6yLZp64h4WzD8KivTFC\\/cIWfy59a\\/hZJFFBlu7lw30aSZGqmEQe2Sx1F\\/dGz3E0BObnj0Iqnrl5boBcMUHrKQW\\/uOnr8tCg1Gh4fl+03dWiqrBn9Nlna+2yjAhQIDAQABo4ICjjCCAoowgY8GA1UdIwSBhzCBhIAUtnSpm5I8x1GxIqRPvLc8\\/iIz13ahaKRmMGQxCzAJBgNVBAYTAktSMQ0wCwYDVQQKDARLSVNBMS4wLAYDVQQLDCVLb3JlYSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBDZW50cmFsMRYwFAYDVQQDDA1LSVNBIFJvb3RDQSA0ggIQBDAdBgNVHQ4EFgQU08zNJ\\/AGJIS3R7YThWPmVV7WtGowDgYDVR0PAQH\\/BAQDAgbAMIGDBgNVHSABAf8EeTB3MHUGCiqDGoyaRAUEAQMwZzAtBggrBgEFBQcCARYhaHR0cDovL2djYS5jcm9zc2NlcnQuY29tL2Nwcy5odG1sMDYGCCsGAQUFBwICMCoeKLz4ACDHeMmdwRzHWAAgxyDWqK4wrATHQAAgADGxRAAgx4WyyLLkAC4wegYDVR0RBHMwcaBvBgkqgxqMmkQKAQGgYjBgDBvsl5DsiqTsvIDsnbQg7ZSM656Y64ubKOyjvCkwQTA\\/BgoqgxqMmkQKAQEBMDEwCwYJYIZIAWUDBAIBoCIEIO0ndMlciC8i4rXTTabKVdLuz5aS3Pb\\/9gsDeciXqGuVMH0GA1UdHwR2MHQwcqBwoG6GbGxkYXA6Ly9kaXIuY3Jvc3NjZXJ0LmNvbTozODkvY249czFkcDlwNzQsb3U9Y3JsZHAsb3U9QWNjcmVkaXRlZENBLG89Q3Jvc3NDZXJ0LGM9S1I\\/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDBGBggrBgEFBQcBAQQ6MDgwNgYIKwYBBQUHMAGGKmh0dHA6Ly9vY3NwLmNyb3NzY2VydC5jb206MTQyMDMvT0NTUFNlcnZlcjANBgkqhkiG9w0BAQsFAAOCAQEAlx3K2jB9idefvdGomJFtXxcg6a2iB\\/ydOcP1G04uTNRX2ddRpT5LS38dUlmreiwepWzBASsDB6FPnt21T9FXSn9Ouyx0FGlaAucluDHjZ+cTCbXtwutGTepy23AR3\\/d7BUeUTrrV1b78SWLhSxySsXCrVlV8vZsVJx3mnDvcyEeJG7wgEzk4ZS9YUzYO3PrWUfgIPY+AXuJs8tPf33O0XlD8OM8AXiw0cGJhnldbv0e0rV9uzlNRKXvFf1BHSSUFm2Xfjxxkxuv0SSRtObS0w4k91ffFBDuQc74IDEGQzjwCErCazer1v5tYToFxSKbq8WO\\/y+hK4FYFCrJ0nU2raDGCAYIwggF+AgEBMFcwTzELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRUwEwYDVQQDDAxDcm9zc0NlcnRDQTICBAEDYIQwDQYJYIZIAWUDBAIBBQAwDQYJKoZIhvcNAQELBQAEggEAhG3jak4rgmtsrL4fNnQh4WTzPxigNCtsYL2DycDwJlq9dFyDQTpEoMmGTgcEzFD2NNc+Nshny+jIOKUnbfNyFcoBt5c116sLO8NjGNNSxxD4+eyo6TEpUAwQ3sgKMto+P+lJKkTtb1fook3V2ztViyd3kiqOeGgbiOH867wwGdLJI1Tk\\/b\\/7Ly3Yts3LmrPX0ffmN6g9Ae1gkLnu9PtcOE9KYjejwtedH9aLsAtI18RlfvSGN6OIdeP9E9RdZQhxU9Y6+e7EQKNojVa4f5SMnjapkeUsA8TE+9DkIExzhbIJyG9IhhasAEqAaynHlvTDsCh+RphIuukTpjcs\\/Avh\\/w==\"}";
	summary = 1;
	market 	= SKT;
	cash	= 3300;

	out.print("[kind]" + ikind + "<br><br>");
	out.print("[idata]:" + idata + "<br><br>");
	out.print("[txid]:" + getSKTtxid(idata) + "<br><br>");
	idata2 = callSKTSite(ikind, idata);
	out.print("[idata2]:" + idata2 + "<br><br>");

	//out.print("" + getSKTSuccess(idata2, cash, strSKTAIDList, nSKTMoneyList, strSKTPIDList) + "");
	if(market == SKT){
		if(DEBUG)out.println("[SKT]<br>");

		if(!ikind.equals("")){
			//1. 데이타를 받아서 json형태로 만들어서 그대로 전송
			//2. SKT에서 보내진 데이타를 넘겨서 > URL포팅해서 전달 > SKT에 인증
			idata2 = callSKTSite(ikind, idata);

			//3. 데이타 파싱하기
			boolean _bSKTState = getSKTSuccess(idata2, cash, strSKTAIDList, nSKTMoneyList, strSKTPIDList);
			out.print("[_bSKTState]:" + _bSKTState + "<br><br>");
			if(!_bSKTState){
				if(DEBUG)out.println(" > SKT idata2 error<br>");
				summary = 0;
			}
		}else{
			if(DEBUG)out.println(" > SKT iKind Empty error<br>");
			summary = 0;
		}
	}
	/**/


    //3. 송출, 데이타 반납
    //반드시 코드는 하단에서 처리해야한다.
	if(cstmt != null)cstmt.close();
	if(conn != null)DbUtil.closeConnection(conn);
	out.print(msg);
%>
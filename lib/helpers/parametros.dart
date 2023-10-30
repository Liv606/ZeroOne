import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// PRD
//const pass_dw         = "776FDED0-8900-4554-AB97-C8BFB301D298";
//const base_url        = "http://rafael.opnet.com.br:33250";
// TST
const authbasic = "testserver";
String baseurl = "";
String autologin = "N";

// Inicializando Aplicativo
const app = "myHomeMQTT";
const idapp = "6000";
const vAno = '2022';
const vMes = '07';
const vDia = '03';
const vHH = '16';
const vMM = '30';
const vSeq = '00';
const versao = vAno + vMes + vDia + vHH + vMM + vSeq;
String auth = "Basic ${base64Encode(utf8.encode('$authbasic:$authbasic'))}";
int pagina = 0;

// Variaveis de ambiente

// Classe Genecicas
// ignore: constant_identifier_names
enum OPERACAO { INSERT, UPDATE }

// ignore: constant_identifier_names, camel_case_types
enum STATE_TELA { START, LOADING, SUCESS, ERROR }

final f = DateFormat('dd/MM/yyyy hh:mm');
final fdate = DateFormat('dd/MM/yyyy');
const ptBr = Locale('pt', "BR");
final fReal = NumberFormat('    0.00', 'pt_BR');
final fReal4decimal = NumberFormat('     0.0000', 'pt_BR');

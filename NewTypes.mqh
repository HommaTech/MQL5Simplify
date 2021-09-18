//+------------------------------------------------------------------+
//|                                                     NewTypes.mqh |
//|                                       Copyright 2021, Homma.tech |
//|                                           https://www.homma.tech |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, Homma.tech"
#property link      "https://www.homma.tech"

enum TRADE_TYPE {
  SELL = 0,       //Venda
  BUY = 1,        //Compra
  NOTHING = 2,    //Nenhum
  INDIFFERENT = 3 //Indiferente
};

enum BINARY_OPTIONS {
  YES = 1,    //Sim
  NO = 0,     //Não
};

enum OPERATION_OPTIONS {
  STOP_ORDER,     //Ordem Stop
  MARKET_ORDER    //Ordem a Mercado
};

enum ENUM_TIME_STRING_TO_INT_TYPES {
  HHMMSS,
  HHMM,
  MMSS,
  HH,
  MM,
  SS,
};

enum PRICE_TYPE {
  OPEN,   //Abertura
  HIGH,   //Máxima
  LOW,    //Mínima
  CLOSE   //Fechamento
};

enum BUY_SELL_TYPE {
  BUY_ON_BID_SELL_ON_ASK, //Compra no BID e venda no ASK
  BUY_ON_ASK_SELL_ON_BID  //Compra no ASK e venda no BID
};


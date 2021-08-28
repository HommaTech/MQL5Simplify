//+------------------------------------------------------------------+
//|                                                 SimpleOrders.mqh |
//|                                       Copyright 2021, Homma.tech |
//|                                           https://www.homma.tech |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, Homma.tech"
#property link      "https://www.homma.tech"

#include <Trade/Trade.mqh>

#include "NewTypes.mqh"

class CSendOrders {
 private:
  long m_magicNumber;
  string m_symbol;
  double m_volume,
         m_takeProfit,
         m_stopLoss;

 public:
  CSendOrders(string so_symbol = NULL,
              long so_magicNumber = NULL,
              double so_volume = 0,
              double so_takeProfit = 0,
              double so_stopLoss = 0);

  void MarketOrderPoints(bool& m_requirements[],
                         TRADE_TYPE m_tradeType);

  bool MarketOrderPrice(bool& m_requirements[],
                        TRADE_TYPE m_tradeType);

  bool StopOrderPrice(bool& m_requirements[],
                      TRADE_TYPE m_tradeType,
                      double so_price);

  bool LimitOrderPrice(bool& m_requirements[],
                       TRADE_TYPE m_tradeType,
                       double so_price);
};

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSendOrders :: CSendOrders(string so_symbol = NULL,
                           long so_magicNumber = NULL,
                           double so_volume = 0,
                           double so_takeProfit = 0,
                           double so_stopLoss = 0) {
  m_magicNumber = so_magicNumber;
  m_symbol = so_symbol;
  m_volume = so_volume;
  m_takeProfit = so_takeProfit;
  m_stopLoss = so_stopLoss;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CSendOrders :: MarketOrderPoints(bool& m_requirements[],
                                      TRADE_TYPE m_tradeType) {
  for(int i = 0; i < ArrayRange(m_requirements, 0); i++)
    if(m_requirements[i] == false)
      return;

  CTrade trade_SO;
  double ask_SO,
         bid_SO;

  trade_SO.SetExpertMagicNumber(m_magicNumber);

  ask_SO = NormalizeDouble(SymbolInfoDouble(m_symbol, SYMBOL_ASK), _Digits);
  bid_SO = NormalizeDouble(SymbolInfoDouble(m_symbol, SYMBOL_BID), _Digits);

  if(m_tradeType == SELL) {
    trade_SO.Sell(m_volume,
                  m_symbol,
                  bid_SO,
                  (m_stopLoss == 0) ? 0 : bid_SO + (m_stopLoss * _Point),
                  (m_takeProfit == 0) ? 0 : bid_SO - (m_takeProfit * _Point));
  }
  if(m_tradeType == BUY) {
    trade_SO.Buy(m_volume, m_symbol, ask_SO, ask_SO - (m_stopLoss * _Point), ask_SO + (m_takeProfit * _Point));
  }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CSendOrders :: MarketOrderPrice(bool& m_requirements[],
                                     TRADE_TYPE m_tradeType) {
  for(int i = 0; i < ArrayRange(m_requirements, 0); i++)
    if(m_requirements[i] == false)
      return false;
  CTrade trade_SO;
  double ask_SO,
         bid_SO;

  trade_SO.SetExpertMagicNumber(m_magicNumber);

  ask_SO = NormalizeDouble(SymbolInfoDouble(m_symbol, SYMBOL_ASK), _Digits);
  bid_SO = NormalizeDouble(SymbolInfoDouble(m_symbol, SYMBOL_BID), _Digits);

  if(m_tradeType == SELL) {
    trade_SO.Sell(m_volume, m_symbol, bid_SO, m_stopLoss, m_takeProfit);
    return true;
  }
  if(m_tradeType == BUY) {
    trade_SO.Buy(m_volume, m_symbol, ask_SO, m_stopLoss, m_takeProfit);
    return true;
  }
  return false;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CSendOrders :: StopOrderPrice(bool& m_requirements[],
                                   TRADE_TYPE m_tradeType,
                                   double so_price) {
  for(int i = 0; i < ArrayRange(m_requirements, 0); i++)
    if(m_requirements[i] == false)
      return false;

  CTrade trade_SO;

  trade_SO.SetExpertMagicNumber(m_magicNumber);

  if(m_tradeType == SELL) {
    return trade_SO.SellStop(m_volume, so_price, m_symbol, m_stopLoss, m_takeProfit);
  }
  if(m_tradeType == BUY) {
    return trade_SO.BuyStop(m_volume, so_price, m_symbol, m_stopLoss, m_takeProfit);
  }
  return false;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CSendOrders :: LimitOrderPrice(bool& m_requirements[],
                                    TRADE_TYPE m_tradeType,
                                    double so_price) {
  for(int i = 0; i < ArrayRange(m_requirements, 0); i++)
    if(m_requirements[i] == false)
      return false;

  CTrade trade_SO;

  trade_SO.SetExpertMagicNumber(m_magicNumber);

  if(m_tradeType == SELL) {
    trade_SO.SellLimit(m_volume, so_price, m_symbol, m_stopLoss, m_takeProfit);
    return true;
  }
  if(m_tradeType == BUY) {
    trade_SO.BuyLimit(m_volume, so_price, m_symbol, m_stopLoss, m_takeProfit);
    return true;
  }
  return false;
}

//+------------------------------------------------------------------+

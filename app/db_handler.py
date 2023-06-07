from petrosa.database import mongo

client = mongo.get_client()


def persist_candles(db, collection, candles):
    res = client[db][collection].insert_many(candles)
    print(db, collection, candles)
    
    return res.acknowledged

def get_backfill_params(db):
    
    res = client["db"]["backfill"].find({"checked": False, "state": 0})
    
    return res.acknowledged
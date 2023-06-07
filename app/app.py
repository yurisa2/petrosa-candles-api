from fastapi import APIRouter, Request, Response
import logging
from app import db_handler


logging.basicConfig(level=logging.INFO)

router = APIRouter()


@router.get("/healthz")
async def health() -> Response:
    return Response(200)


@router.get("/")
async def root(request: Request):
    result = {}
    
    return result

@router.post("/candles")
async def post_candles(request: Request):
    req = await request.json()
    db = "petrosa_" + req["market"]

    col = "candles_" + req["tf"]

    result = db_handler.persist_candles(db=db, collection=col, candles=req["candles"]) 
    
    return result

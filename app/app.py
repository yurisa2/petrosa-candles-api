from fastapi import APIRouter, Request, Response
import logging

logging.basicConfig(level=logging.INFO)

router = APIRouter()


@router.get("/healthz")
async def health() -> Response:
    return Response(200)


@router.get("/")
async def root(request: Request):
    result = {}
    
    return result

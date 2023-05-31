void positionChecking()
{
    if (xUniciclo > ringWidthSize / 2)
        xUniciclo = ringWidthSize / 2;
    if (xUniciclo < - ringWidthSize / 2)
        xUniciclo = - ringWidthSize / 2;

    if (yUniciclo > ringHeightSize / 2)
        yUniciclo = ringHeightSize / 2;
    if (yUniciclo < - ringHeightSize / 2)
        yUniciclo = - ringHeightSize / 2;
}

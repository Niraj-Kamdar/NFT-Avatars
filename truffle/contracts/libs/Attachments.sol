// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Attachments {

    enum Top {
        longHair,
        shortHair,
        eyepatch,
        hat,
        hijab,
        turban,
        bigHair,
        bob,
        bun,
        curly,
        curvy,
        dreads,
        frida,
        fro,
        froAndBand,
        miaWallace,
        longButNotTooLong,
        shavedSides,
        straight01,
        straight02,
        straightAndStrand,
        dreads01,
        dreads02,
        frizzle,
        shaggy,
        shaggyMullet,
        shortCurly,
        shortFlat,
        shortRound,
        shortWaved,
        sides,
        theCaesar,
        theCaesarAndSidePart,
        winterHat01,
        winterHat02,
        winterHat03,
        winterHat04
    }

    enum HatColor {
        black,
        blue,
        blue01,
        blue02,
        blue03,
        gray,
        gray01,
        gray02,
        heather,
        pastel,
        pastelBlue,
        pastelGreen,
        pastelOrange,
        pastelRed,
        pastelYellow,
        pink,
        red,
        white
    }

    enum HairColor {
        auburn,
        black,
        blonde,
        blondeGolden,
        brown,
        brownDark,
        pastel,
        pastelPink,
        platinum,
        red,
        gray,
        silverGray
    }

    enum Accessories {
        kurt,
        prescription01,
        prescription02,
        round,
        sunglasses,
        wayfarers
    }

    enum AccessoriesColor {
        black,
        blue,
        blue01,
        blue02,
        blue03,
        gray,
        gray01,
        gray02,
        heather,
        pastel,
        pastelBlue,
        pastelGreen,
        pastelOrange,
        pastelRed,
        pastelYellow,
        pink,
        red,
        white
    }

    enum FacialHair {
        medium,
        beardMedium,
        light,
        beardLight,
        majestic,
        beardMajestic,
        fancy,
        moustaceFancy,
        magnum,
        moustacheMagnum
    }

    enum FacialHairColor {
        auburn,
        black,
        blonde,
        blondeGolden,
        brown,
        brownDark,
        pastel,
        pastelPink,
        platinum,
        red,
        gray,
        silverGray
    }

    enum Clothes {
        blazer,
        blazerAndShirt,
        blazerAndSweater,
        sweater,
        collarAndSweater,
        shirt,
        graphicShirt,
        shirtCrewNeck,
        shirtScoopNeck,
        shirtVNeck,
        hoodie,
        overall
    }

    enum ClothesColor {
        black,
        blue,
        blue01,
        blue02,
        blue03,
        gray,
        gray01,
        gray02,
        heather,
        pastel,
        pastelBlue,
        pastelGreen,
        pastelOrange,
        pastelRed,
        pastelYellow,
        pink,
        red,
        white
    }

    enum Eyes {
        close,
        closed,
        cry,
        dizzy,
        xDizzy,
        roll,
        eyeRoll,
        happy,
        hearts,
        side,
        squint,
        surprised,
        wink,
        winkWacky
    }

    enum Eyebrow {
        angry,
        angryNatural,
        defaultNatural,
        flat,
        flatNatural,
        raised,
        raisedExcited,
        raisedExcitedNatural,
        sad,
        sadConcerned,
        sadConcernedNatural,
        unibrow,
        unibrowNatural,
        up,
        upDown,
        upDownNatural,
        frown,
        frownNatural
    }

    enum Mouth {
        concerned,
        disbelief,
        eating,
        grimace,
        sad,
        scream,
        screamOpen,
        serious,
        smile,
        tongue,
        twinkle,
        vomit
    }

    enum Skin {
        tanned,
        yellow, 
        pale, 
        light,
        brown, 
        darkBrown, 
        black
    }

    enum ClotheGraphics {
        skullOutline,
        skull,
        resist,
        pizza,
        hola,
        diamond,
        deer,
        cumbia,
        bear,
        bat
    }
}

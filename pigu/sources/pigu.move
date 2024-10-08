module pigu::pigu {
    use sui::url;
    use sui::coin;
    use sui::tx_context::sender;

    public struct PIGU has drop {}

    const DECIMALS: u8 = 5;
    const SUPPLY: u64 = 100_000_000_000; // Without decimals

    fun init(otw: PIGU, ctx: &mut TxContext) {
        let logo_url = url::new_unsafe_from_bytes(LOGO_URL);

        let (mut treasury_cap, metadata) = coin::create_currency(
            otw,
            DECIMALS,
            b"PIGU",
            b"PIGU",
            b"The thiccest penguin on Sui",
            option::some(logo_url),
            ctx,
        );

        coin::mint_and_transfer<PIGU>(&mut treasury_cap, with_decimals(SUPPLY), sender(ctx), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury_cap, @0x0);
    }

    public fun with_decimals(val: u64): u64 {
        val * 100_000
    }

    const LOGO_URL: vector<u8> = b"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEASABIAAD/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCAGQAZADASIAAhEBAxEB/8QAHQABAAEFAQEBAAAAAAAAAAAAAAcCBAUGCAMBCf/EAE4QAAEEAQICBgUHCAYJAwUAAAABAgMEBQYRByESEzFBUWEIFCIycRUjQkNSgZEkM1NiobHB0Rc0cnSS4RYYJTU3RIKTokVVg1Rjc7Lx/8QAGgEBAAIDAQAAAAAAAAAAAAAAAAMEAQIFBv/EADMRAAICAQQBBAADBgYDAAAAAAABAgMRBBIhMQUTMkFRFCJCFSMzQ1KBBhZTYXGRocHx/9oADAMBAAIRAxEAPwDpkAFgiAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAKJZo4m7ySMYniq7FhYz2KrpvPkakaecqIMGG0uzJA1axxA0rAu0mdoov8A+VDw/pK0eq7fL9L/ABmdkvoxvX2bgDVmcQdJyLyz2P8A+6hlKupMNb/q+VpSfCdBsa+BvX2ZUFEU0UqbxyMenku5WYAAANgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADxt2oKld89qVkULU3V712RCItaccMXjpH09NwLk7icusTlEi/xMwrc/aaNpEwyyMiar5Ho1idqquyGjal4q6TwHTZPkWWZ0+qrJ1i/yOd89ndU6tkc/NZOSKsvZXiXoM/BP4lnTw1Orz6vrH+Ly5DR/wBZC7/ok7Mce7dlXR6cwbvKWyv8E/manf19r3KqvTyTKTF+hAxE/wAzGNRGpsxERPJCosKmC6RC7GyxuQ5XI7/Kebu2Wr2osqqh4Jgan03yP+KmVBKab2Y1uFoJ9Vv8VKvkel+hQyAA3MxzsNQX6hChcFT7kez4KZQAbmWMNS5U/qGVu19uzoSqhm8fq3W2LVvqudfYY36E6I/f8SyBiUYy9w3M3jE8bs7S6LM5hobLN+cldegv4G/ab4yaVzDmRT2X4+dfoWW7J+PYQT3FvYp1502miYvntzIJ6WDJFc0dgVrUFuJstWWOWNex7F3RT2OPMVPl8DL1un8rZqr+j6e7F+4kbTvG2/SVkGq8d1jOz1mt/FCtPSzj0TQvT7J9Bg9Narw2pa6S4i9DP4s32enxQzhWaa7J00+gAAZAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB4X7lfH1ZbN2dkNeNN3vkXZEQGp7kccQ+K2H0oj61dUv5PsSvEvJi+akb8RuL13OzTYjR3Thq82SXOx7/h4IR9jcTHUXrJF66deayP5lynS5/NMhsux0ZDUWd1DrSz1+ctvgp7+xWjXZifceFSnXqN2hjRPPvLkF2MVH8sSq22AAZNQAAAAN0TvAAKekzxQdNACoFPTQdJniAVApRU7lKgAAAAHc02VN0AALNlN9eylvF2JKVpvNJIl2JF0lxlyWIdHU1dWWzW7PXIk5p8U7zRil7UkYrHoitXuU1srjP3G8ZtHV2BzuOz1FlvE247MLu9i9nxMkccY2XKabv/KGmbcleROb4d/Yf8UJx4c8XaOoJGY7OMTG5bs2evzcq+S/wOfbppQ5RbhdnslYBF35oCuTAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAs8tkamJx892/KyKtCzpveqg1PHUOaoaexU2QyczIa0Sbqq9/knmcr651rleImTexqvq4SJ/zcCd/mvipRrzVl/iNnlVVfDhKz16mLx818zzhiZBE2ONiIxDo6fT7OX2V7LPhFFOrFUibHAzZqfip7AFkrAAAwAGNVz2sYive5dkRE3VSRdI8LbuTRljMvWnWXmkae+v8iO66FKzNm8K52PCI6Yj5XIyNj5H+DE3NowugdQZZGrHTWvEv05eRO2A0ph8FEiUacaPT6x6bqpnF32ORd5V/y0X69D/WyIMbwc3RFyWTXfvZEhslHhXpyt+cjmsL+u43K9ep4+JZL1qCsxO+R6IaPmuMOj8WrmfKPrL07oG7lT8Tqr+ix6FNZsFfROnIE9jFwfem5eM03hmckxlX/ARFkfSGxkaqmOxFmXzkXYwVn0iciv8AV8JAz+3IbrR6qfY9SpE9u07h1T/dlX/AW82ksBN7+Lrc/BCBf9YbN7/7qqfipdVvSJvp/WsJCvj0JDP4HVL/AOj1qmS3c4baatI78idE5e+N+xr9/g7jpEctG/PC7uR/NDB4z0hcPKqJkcZar+Ks5m8YHijpHNK1tfKxxSL9Cf2FMZ1lX2Y2UzI5yvCnOU0ctR8dxieHJTSsljL+MlVl+nPC5PtsXY6tgljmjbJBIyRi9j2LuhTcqV7kSx24I5mL3PTckr8rYveskUtDGXsZyQ1UVOSlROepeFWMvo+bEPWlP29DtYpEmo9NZTT1h0eSrKkXdKzmxfvOtRq6r+nyUbKJ19mHG/Ifx7EQk/h7w1feSPI6gYsdftjrd7/ib3XwoW+ZpXW7HhGl6Z0rldRS7UK6pDvznfyYhID+B2Mt416X7si5FU+bnj5JGpIGd1BgdG4lr788FKs1Pm4mdq/BCFtT+kHO5749M45iMTsnsdv4HL/E6nVP9ysI6MaKqvf2ZjTWsM5w9zEWnte9ObGKvQq5Pbf4bqTjBNHZhZLA9JI3Juj0XdFQ4n1VxA1HqqB1bM2Y5ayrukbI+xfI2TB3OKGmtOss0Ib8WHYnTTpxo/ZPgvNELUtO2k58Mi3YfHR1uDnvh/xI1/qeO18m0sZf9URFkYqLG9fhz2JA03xOq2r7MXqWjZwWVXkkdlPm5F/Uf2EMqpRN9/2SID4ioqbou6H0jNgAAAAAAAAAAAAAAAAAAAAAAAAqoxFVV2RDmHjJreXV+cdgMTJ/smq/52ROyV6fwN94/a4fh8Y3BYmX/ad5Nnqxeccf+ZCmIpJSqonbK/m9fMu6an9bK10y5rQR1YWRQpsxP2nqAXSoAAAD0p1Z7tuGtUjWWeVegxiHn2E28GtLspY75auxp63P+a3+gwr6rUrT172TU1O2WDJaA0BUwETLeQYljJqm6qvNI/JDfT4qbmn8TdcU9D4B9yfaW5L7FaDve/8AkeYk7NVZzy2dmMI1R4MxqXUmK0xQdczNtleJOxFX23/BCANZ8esjefJX0tXSlW7PWJU3evwQinU+ospqjKS38zZfNM9fYj39iNPBEPul9N5TVGUTH4Wss06++76DE8VU7mn8dXTHdbyypO+c/aeGXzOTy8zpcpfs2Xr29Y9f3GP2ROxDonC+jhCtdj8zmJlnVObIE2RCw1T6OtqrVfNpzJrO9qb9RP8AS+8trVVdJkWyfZo3BrQCa6zliO3IsWNqIjpVb2vVe5CatWcB9OWMJN8iMkq342bxv6W6KqeJFXB3Vr+Gmqr+P1NWkrQ2dkl3TnG9O/4E1aw4y6XxuEmkx99l25JGqRRRe1uvmVtRK31PydG0NmOTkOxDJXnmrzptNE9Y3p5oUHrbnkt27Fmb87NIsj/ip5HRIQZvQ2Nr5fWGKx91FWtZlRkmy7LsYQ2fhd/xF0//AHlBPhMzHsnm9wt1LpaR9vQGfn6Cc/Ura9Ni+ReaS4qqmTZg9d0H4XMdjJHp81KvkpM30UNa1vozEaxxb6eXrteu3zcqcnxr4opwJSjbxYv7lxZh7TKIqKiKiorV5oqd543ale9WfXtxMlhcmysem6EVcM8xktL6lm0LqidZ1anTxtt/1sfh8SXDn21umWCzBqaNDxfDHD4/PrkUV8kLV6Udd/YxTKcR9XVNF6anyNhEWbboV4vtv7jaNjmn0qrssmo8PQVV9WjiWTbuVSxpt+rvUbGQzSqh+Qi3NZbM6xzvX21mu37L9o4mc9vJEN7xvAfV1uik8zqtZ7k3SJ67qbJ6KuDrW8jlMvYYx81baOLdOzfvOm99+SHY1GqdL2QXRVhXv5kcK2tO5HQ+rsamqqSx147CPV6c2SJv3HXN7Wemo9KvvPyNR1NYeTOmnPl2bGK474KpmeHeSWwxnW1mddE9e1FQ534RcMWa9xd25PlH1Y4PZZGi78/FfI1coaiG+fGDZZg8I3/0V5Y5s5qeSFnQhkej2J4JupOmqNN4vUuPfUy9VkzFTku3tMXxRSDPRdqLj9RaopuekiwObH007HbKvM6OK2qeLco2r9pEek8rf0pq5uj8/YfZrTsWXF3Hdr2J2xv80JNI14uxJPrPQ0dfo+vpf6aeKRontklIZfKTNFw8AAGDYAAAAAAAAAAAAAAAAAAGI1bnq2mtP3MpdXaOBm+3217kQy5zh6RGpn5fUFXS9F/zMCpJY2XtevYn3J+8kqr9Se00m8Ij9luzqDN3M7klV008iqxF7k7kMiUQxMhiZEzkxibIVnVKDeWAAZNQAAD3oQetZCtB+klRn7Tq6lAyrThgjTZkbEYiHKmJmSvlaM6+7HKxV/E6ugkSWGORnNrkRUOH5fP5DpaD5Kzjnjfn5c9xBvo96rWor1ETO5PFTsY4m4p46XGcQs3BOiorpeuZ5opp4hL1GWNVnaaqvZy97uOzeB2kq+mdE039W3122xJp5Nua79xxmi9FzHr7qPRf2nfOjbMVzSuKngcjo312Kip8Do69tQSK1PZnAAcssEEek9pOC3p6PP14kS3VXoyuRPeYviRrwY4Uwa4pWchfsugpxv6tiR9qqTv6QF6CnwzyiTLzmRI2N8V3OaOHPEfMaEjmhxzI5q0vNYpexF8UOnppWSo2w7K88KfJ4cT9HP0Rqhcb1/XQyM6yJ/ft5mpGY1dqTIaqzkuUyr0Ww5NkROxieCGHL0N21buyJ4+AbPwu/wCIeB/vCGsG0cLv+IuA/vCCfsYj2d2J2IfQnYUucjWqrl2RO888XSD/AEiYWVMvo/K116F2O8kaK3tVFJdjXpxsVe1URSFdR204kcYMbjscvWYnBL11iVPcWTwJpmljghfLM9I4Y03e9exEQj1nthD5NqfllacyGfST0dYzGDrZuhEslnH79YxE5rGYrVGvMxrTKzYzSE76GHgXoS307ZF8jHwZPXumd31cgzOUPp17Cc1Q1pktPaszSn9Fp6W2+vfCGUabwP17FovUD1vb/Jl3Zkqp9Wvcp1xR1DiMhUSzUyFWSFU36SSIcp2sBp/XluV+AemA1C787jLPKORf1FNSzWitU6fc+K7jr0cadqwKqsX8DsWwrvec4ZzVvhwTX6QPE3HyYabTeCsJYs2PZsSxru2Nnhuc94/JX8YkqY27ZqpInQekT9umnmWzopIlcj4pGO7+mxT7FFLKu0cU0jv1GKpbppVcMIhcm2T56JjlXJZ5yq5XKxm6r8SetU6lxel8XLey9lkMLU5Iq83L4IhyvwndrjCLdTTWDe+S4iJ19hOgyPzJIocH8jqCaW/xDzMl+05i9VXjXaOJTm6rYrN82WK08cGb4cxWtY6gm1vk06usrFgxdde2OPfm9fNSUewgfgxmbekdWX9C51+yJIr6T17/ACT4k8dosWJcdGkP9wADQ2AAAAAAAAAAAAAAAAAAMbqbLRYTAX8jOuzK0SyfHZDjvDyz5PJX8xdXp2LMqv3XzJu9JzOrT0xSw8L9pshL7aJ9hP8APYiGhAlelFEncnMv6SGFuKt7LgAFsqgAAAAADtOg+E+omZvTrK8z/wAsqfNvTvVO5TnwyWnM1bwGVjv0X+21fbZ3PTwKmr0/4ivHyT0XelLJ1SvIibjrw4fqzHsymIYiZioz3P07PA37SmpKWpMayzSkb0/rIlXmxTNoebhOzT2Z+Udl4tifn/NFJBNLXsRvisRrs+N6bKik6cAuKdfDwM03qKXq6yL+TWHryTyUlHiBwxwOs2ulsReq5HusxJsq/HxOfdYcG9T4HrXw10yVNOySBOe3mh3oaunVw2T4ZSdc63uOx69qG1E2SvLHJG5N0c1d0U8MnlaOLqvsX7MVeFibq57kQ4RqZzUOC3gr5HI0tuXVvVURPxLTJZjJ5dd8pkbVzykkVU/AwvH89mPWJD438R01rk2U8ZumHqryVfrX+JGA7E5A6MIRhHbEhcs8gAbkhgGz8Lv+IuA/vCGsN9pdmIr18ETc3DQ2ldWWsxUv4LFzJNA/pxyys2YikVkkoPLMpZZ2rlcrSxFN9nI2Yq8DE3V8jtiD9S6/zXEa5Lp7h5DJFSVehZyr0VERnf0C4o8JcnqC22/xEzk15d9/UoFVI08iWcPi6GHosp4utDVrMTZGRpseenfXV7eWXlW5dmF0Do7H6MwbKFFOsmd7diwvvyv8VNC496gszTUNH4mRY7OQ9uy9i82REx95EnHfTNmWKnqvCMc7IYz86xE5yRd5Xom525ff/smxFYT6MNhaVXG0WUKPQakKbKidu/ipfLs7kppi1YtU1K+ZwF19K/tsqovJV8HoUOn1xWRWLFRsNT6zfY470jsfM1n5T4PYw1PpriHHxgy2pdM1c5F1m3q+Qj5xWY+SopsfBnX1m/fm0hqZWTZOqi9VY7UlYnj5kN5XOapymQbiKsrJbMi7dXS5/ipOHBbhh/ok12WzL+uzc7du3fqk8PidurTT0+nxfPP0jzXkdRVqLf3UcP5JImw2MmXebH1Hr4rEh9hxGOhXeHH1Y3eKRIX2w2Ke9lbCCIjE2RERvgiFvftwUKU1m09GQxJ03qouW4KVV9i3KkUMabq96kBcR9cS6ln9TpKseKjXl4yr4qWdLpZ6iePgr33qpf7mlcR85ZyWqU1PUVY5q0qLFt3MReR1Lo/NRai01j8pB7tmJHqngven4nKlmFJ60sS9j02JV9GLMrLhclg53/OU5enGi/YX/M7+oqSrWPg51Njb5JuABRLQAAAAAAAAAAAAAAAAPkrkjje9eSIm6g1OWONmQXM8WVrb7w4+NkafHbdf3mJLBLS5TVudyfT6aS2XqxV8N+RfnYhHbBRKNjywADYjAAAAAAAAAL3DZa5hb7bmOnWKZO3wf5KTbo3iXjcw1lfKKlK72c/cf8CBQ5NytqdJXf32TU3yq6OuY3pIxr2KjmL2Ki7opUcy6c1pm8CrUqWVkrp9VLzQkrB8XMfYRrMxWfVk73s5ocS7xttfXKOjXra598G+ZbT+Iy8bkyOOq2N+98ab/iaXk+DGj7quVlKSs5f0T+RuWM1Hh8mxFpZCCTfu6eymWaqOTdqoqeRUVltXCeCxiMyGLPo94B6r1GRuxeXJSz/1dsZvyzNro/2EJ02PpLHXaj+sx6ESEYPR5wjF+eyl2TyREQzeP4H6Qqq1ZorNlU/SSEp7nzn4GJa29/rCqgvg1vD6I05iOj6jiKrHJ9NWbr+02NiNYzoMRrWp3Imx92XwGy+Cldzc+2SJJdAH3YGpsfCh7GvY5j0RzFTZUXvQrABB2ruGeZwWbmy+g+rkrWV3nx8i7Jv4oWdDhjrDUrkfqfJsxlJV51q3vqnxJ8XdewJunapY/EPO/Cz9mFOyMfTUvy/RrOjNE4TSNbq8TUakn05385H/AHmzAtMlkaeNrunv2I68ad71IW52PL5ZjiCLvtMJqbU+M05VdLfnb1v0YEX21I71dxZ5Pracj9rs9Zk/ghFN23YvWX2L075rD13V713Opp/GznzZwilbrUuIGf1nrHIaoncky9TRRfYgRf3+JrScgDuwgq1iBzHNzeWDKcIciuG4sQR77Q341hX49qftQxZjprC47UmEyCLt1Nliqvkiicd0dpmEsM7PB8hckkTHp7qpufTjl8AAGwAAAAAAAAAAAAMJra8mM0llrjvqqz3fsM2R3x7vLR4aZLoJzm2h/FTMFmaRpPo5t0q3bGuk/SP3Mwa5Sy9bH4uGP85Lt2IefyhlMgu1WPq2L37HZKLg28myuVjffVE+Kni+5Wb788afeYOPA2Zl3t2V+CKXTNOU09/rHr5qDGF9l/8AKNNf+Yj/ABPSKzBJ7ksa/eY/5Aofo3fiUO07U+rWSN3koHBmgYiPG26/9XuqrfCTmZKDrer/AChGdPyBg9QADAAAAAKXLsirtv5AFTN2rvGqtd4sXYvY9X5PDpuzMTxN8FfuYCZuQtdJEeytH+L1PKLA1t+nYe+Z/i9TDSfZuuPk2pnHLUFX2IZI7W3e9m257u486umjVIMbVR6/T2U1yGjWhT5uBifce7UROxET7iB6Sl/oJVqJLpl3Z4qcRLvS6E8cLV7mRGOk1dxBse/mJk+HI99xubKipdQRj8TMsvl/Xn/vlr8T2h1XxBgX2MzO/wCPMuAb+jX9GPXme1bidxEpbb2WTNT7cZmaXHrVNRWpkcVXsM71RNlNf3PjkRe1EX7iJ6Sh9wNlqrESdhfSGws/RZmMdZpv71RN0JCwXEfSmaZvSzFZF+xIvQU5mnx1SZPnIGL8DFWdM1pF3gesbytPxdL64J4a1/J2W/OYpkfTXI1eh49YhruX4j6cx6OT1xLD0+hEm5yQ/H5ShzhkkkYng9V/YXtLPsReruxdW/xRCOHiK12zaWrl+gm/PcXr9jpx4asysxeSSSc1I7yWSu5SZ0uStyWHr9teX4FhXnjnj6cL0enkepfp01dPsRSnZOfbAAJiMAAAGH1On5HE/wCzIimYMXqRN8VKvgoNodnYOm50tYDGzp2SV43/AIohkTXOHDus0LgX+NOP9xsZxX2X4dIAAG4AAAAAAAAAANB4ncSMdoqr1SflOVlT5quzu818ECi5vCMN4Nn1JqLGabx77uYtx14W9m683+SJ3nNfEniJkOIKfJ2Mq+q4Zr9+nJ78ip3r/I17JT5XVeSdk9TWXyuX83F2IxPBELxjGRNRkaIxidyHRp06hzLsq2XZMVQwVarzkTrZPFewyrURqbIiI3yK4Y3zSsigYskjuSMYm6qSdpLhTYtsZZ1BIsMS80rs7V+JvdfCpZmyKEJ2vgjGGOSeVsdeN8r/AAjTdTZsXoHUmRRqx0OqYvfKuxP+G0/isNE2PHUoYtvp7bqZVTlWeXf8tF6GhX62QTDwhzrmbyWasbvApk4RZ1qbx2ar3E8bDYrftS8m/A1HNmS4falxzXLJQ65id8S7msWIpK8nV2opIXp3SJsddbFhksNjsnG5l6lBMi+LE3J6/Lv+YiGegX6GcppzQE45nhLh7XSfjZpKT17t92GlZXhZnaXSfA+CzGnPdF25HRr8hTZ8lWelsh8GgRSskV6MXdWrsqFC2IkmbB095V7kMQyDJ3dR3qGDifNN2SdWm/Q8VNkxekMpVj2ZjLUky+/IrF3UtOaXbIvTZ4A2WjoPUlxU6vHPY3xkXY2jFcH8hMrVyl2OuzvSPmpDPVVQ7ZuqLJ9IjByoic1RD2q1bNtdqlaaZ36jFU6AwnDHT2NVHzQLclT6cq8jbqtGpTj6FWtDE1PsMRCjZ5WC9iyWYaGT7ZzdT0RqS5+bxcjE8ZF2L93DXVCN39UhXy6Z0Y1HO7CvqZPArftS59Im/A1rtnLl/SGoKKOWxi5uinezmYOVHxP6E8b43+D02OvlikTtTcxOVwGLysbo79CCTfv6GyksPKtfxIEc9Cv0M5XBLup+EbNnz6dn2Xt9XkXl9ykV5Kjbxtt9a/A+GZvc9Dp0amu9fkZSspnX2WwAJyMAAAFpcx9a2zaaNN/FO0uwDJrFjE3Mc7raEivYncX+Kzcdh/UWk6qwnj3mYLDJYuvdTdU6uZOx6A2znsvwYWlbnoypUyXNF5Ry9ymaBq1gAAGAYzUf+6JjJmI1Ou2MVPF6A2h2dWcLt/6P8H0//pY9vwNpMFoOH1fRmEi+xTjT/wAEM6cafbOhD2oAAwbAAAAAAAAwWs9R1dK4Czkry+zGnsM73v7kQJZeEYbwa1xd4h19F4rqq+02YsptBF4frr5HN9OvZu3pcrmZFsXZl6aq9dyuSzc1Lm7OdzD1fJM/eNi9jE7kTyMidWmlVIpWWZB6U6s921FWqRrJPKvQYxDzVdkJu4QaSbj6SZi9H+WTp80ip7jDTValUV72KanbLBmeH+hqmm6qT2GMmybk3fIqb9DyQ3U+H08tZZO175nahWq1hAAEZIAAAAAAfUXcgDj5r25LfZo/TMj1tzKjLEka891+ghK/ETUsWlNJXsnIqdYxnQiTxevYQ76O+lZMxlbmsMwnWv6xUg6fe/vUv6SCgnfZ0ita8vYiTeEmhK+idOxxvYj8pOnTsz9+/gb70j4fClZY7J72TqCSwfeYANTY+KVxM6btvolCnrWVEeu/ebV4clkxLovWtRqbIh9AOiVQUPY1ye0hWDDWQWE0Ss59xgtS6cx2o6ToMhEiu+hKie2w2l6dNqopYObs5U8CrOLqe+BMsWLDOYtZaUu6WvdVYTrKz1+anROS/wCZgDqrOYipmsbJSvRo+J6cl8F8UOa9VYCzpzMS0rSbpvvFJ9tDu6HW+usT7OXqNP6T3LoxIAOgVAAAAAADysQxzxLHMxHsUVolhhbH01e1OxVPUAyAADAMXmIvWrOOqJzdNYYzb7zKHvo6n8q8TsBV23ZFJ1z/ALuf8DEpbVuNodnWNKFIKVeJibNjjRifgewBxjoAAA2AAAAAADlRrVVeSIcr8W9VP1rrD5Pqv/2PjlVN0XlI/vX+BMPHbVL9NaImSrJ0Lt5fV4vFN+1fwOd8DT9Uot3/ADsnN5d0lf62Vrp4L9ERrERE2anJCoAulQ2Hh/hFz+qKlZU3gjXrJV8kOmGMSNqNYiIxqbIiEYcCcX6viLmSentzv6DF8kJSPN+Su9S3H0dfRV7K8/YABzi6AAAAAAADxsTMrVpp5F2ZExXr9wMHOfpF5efP6zxGlKD1c2NU6xGd71UnvS2HhwOn6OMrMRGQRoi7d696nO3ByB+r+MuUzc6dOOs98iL9+yHUHap0dd+7UKF8FejluYABziyAAAAAAVNlkTvKuvenmeWw2Nt7XyY2ouWWvtIe7Ho9N0Ux+x9Ryt7ORJC9rs0dafRkHLshYPXeRyn1ZHuTZVPSKBFTdxtNu3hGEtnZ4mn8TNMs1Fp6Tq2fltb5yJdua+RvL66bcuSlr2LzNVvompoNKxYORNlTdHps9F2VPBQbhxXwqYbVkiws2r2065nhv3mnnrK7FZBTRwpw2PDAANzUAAAAAAFjkppKqMsJ0liYu0jPLxL4pfGksb4382vTZQZQY5kjWvYu7FTdFNz9HbHfKGs8vln82VI0hjXzX/8AhE9fI/JsNqlPvuzfqlOl/R4wj8ToCGxMxUmvyLYXfw7E/YhX1M8QJq4cknAA5pdAAAAAAABb37DKdGxZkXZkUavX7kBqc18dswue4i18VG/etjGe2n6681/ga6YvHWpMpl8nl5+b7Mz3/iplDsQhsSiULHlgpf8Am3FRSvPo/FDY0OmuHlRKejcbGibOWPpr95sZYafajcFjkb2ers/cX6njrnmbZ6CtbYpH0AEZIAAAAAADVuJt/wCTdAZuyi7OSuqJ95tCEaekTZWvwvyCIu3WORhNplvthEjseIs1P0TsckWnMrkFT25pUYik7r2EXejdWSDhnWXbZZJVUlFSTXPN82a0LEEfQAVSYAAAAAAAAAAAANT2k+JkU7DH7nvHY2TZ5PRNLsisi2XO+5jnu3kfse0ljdNmfieAvsUvyoVwa7I046Y1J9PVrrU9utJzXyUg86W4iVPXNG5KNU32j6afcczxru1Pgdzxc81Y+jma6GLNxUADpFMAAAAAAAAAwOVpRTZ7G9evQgmlZHK/wTfmdqY6vFUoVq9dESGKNGMRPBEOMtTsVcd1idsa7odcaGvLk9IYe4q7rLWjVfjtzKWsXCZboZnQAUiyAAAAAADTeMGQTHcOM5Lvs59dY0+L+X8TciLPSOspDw4sRd80saft3Nq1maNJ9EBaci6rEQ+fMyRbY1vRx9dP1C5Owc+XYKXry38F3Kil6bsVAYOqdMSpPp3GyJ3wIZR3Yahwqvpd0TS57uh+bU2/uPH3Q2WNHoKnugmfQAREgAAAAAB8Qiv0lWq7hlYVO6VNyVENA47U1u8MMu1qbrGzpljSvF8GR2+xlv6Pjkfwwx+3c5dyR1Ii9GC56zw6WLfd0MytUl1TOrji+Zin2I+gArEoAAAAAAAAAAAAAAAAABitToi6dyKO7Oof+45Wi9w6j1nMkGlcnIvdApy5F+bad/xHtZy9f7kVAA6xzwAAAAAAAACxzbeni7CeR0RwDtLa4X4lVX2o+nH+D1Oestyxs/8AYJ79HRvR4Y0V8ZZF/wDMq6v2Figk4AHPLgAAAAAAIf8AScjV2h4Hp2NspuTARt6QlVbHDLIKxN3RPjf/AOaElLxYiOzogSkv5DB/YQ9izw8nTxcC+ReHWKDAABglbgRlkZPfxMj/AHvnI0/eTKvYcp6fycuGzVXIQrzienTRO9O86jxt2LI0IbddUWKViPRTz/lKNlnqfZ1tDZmGz6LoAHKLwAAAAAB8UxeqKCZPTeTpuTfrq70RPuMqfEMqWHkw+Uc6+ivkVp5DPYKddpGv6bGL5Lsp0UibHMGbjfw448w3VRWUL0nT3TsVH8l/adOtckjEexd2OTdF8UL3kFmasXTIKHhbSsAFAsAAAAAAAAAAAAAAAAAAGkcX7qU9E2W77LMqRp5nPTU2TYlTjxlutu0MVG/dIk66RPPuIrPTeMr2Up/ZxNXPfYAAXysAAAAAAAAAY7UEnV4qwvih0twSprS4ZYSNybK6JZP8aqv8TmLUW8sVaozm+aVGInidj6epJjcFQps92CFkf4IVNZLhItUIvwAUC0AAAAAADX+IOOXK6LzNNibvlrPRnx25GwFL2o5isXsVNgnh5MNZRxXpeTpY7q3dsb9lMwWmSorgNfZvEycmJMqx/BeafsUuzsxluOdNcgAGTUEncHtYeo2fkTIybVpV3geq+4vgRiOxWqi7OTmi+BDfSr4bGb12Ot5R14fO0ifhlxESdI8RnZESbshsL9PyUlk8tfROieyZ3KrVYsoAAhJQAAAAACPeNOiE1jpZ/q6ImTp7yV396+RbcC9Vu1Bpb1C8qsyuMXqJ439uydiklEUa005Z0rqqLWum4lfHv0MpTj+sj+2nmhdpmrK/Sf8AYhnHa96JYBa429XyVGC5TkSSvMzpsVC5UpNYJVyfQADIAAAAAAAAAAAB83LbJXYsbQsXLKo2GFnTUuSDeL2sUyVl2Gxsn5JC/wCfkRffXwLOl071FmEQ33KqOTRM9k5MzmbWQlXnM9VTfuTuLEdwPVpJLCOE3nkAAyYAAAAAAABRNKkML5H+6xNwZLjQuNXP8UcPU26cNV/Xyf8ARzOuUIF9GXBukbk9SWWc7D+oh38E5qpPRzdVPdPBepWEAAVyUAAAAAAAAA549JXTklTJY7VNRnscoLG3j3L/AANDgmZPCyVnY9NzqzVmDrak0/cxV1N47Eat38F7lORYalvT+auYLKIrJoJFRir3p3KnxOhpbcraVb4fqMmAC0VQAAClybp+5SUOHXEiTH9Vjs+9ZK3ZHYXtZ8SMT44huohfDZM3rsdbyjretPFZrslrSMlhcm6PYu6KeqLuc0aR1lk9MStSu9Zqar7dd68vu8CcdJazxWpIU9VmSKzt7cEi7KinntVobKOe0dejVQs4+TZwfT4US0AAAChyIqKjkRUVNlRe8rABZ43H1sbXWClGkUPTV/QTsRVLwAN5AAAAAAAAAAAAB8CqiJu5URqd5a5PI1MXUfZvzshhYm6q9SENecSLOZV9LD71qHYsn05P8izptLZqHx0QXXwqXJnuJvENGMmxGCl3evKawxezyQh7/wDbvU+tTYHpqKIUQ2QONZY7HlgAExGAAAAAAAAADF5GGxlchSwlBFdZtSIzZC8uWmVKz5ZF7OxCS/R20fJLLPqzKxbSy7spo9O7vf8AwI7Z7I7iWuGWTLpXDQaf0/SxdVESKvGjPiveplgDkt5LyWAAAZAAAAAAAAABEHHvQy5nGNzuKjX5Topu5GfWRp/Il8ORHI5FTdFNoTcHlGjWTjLD5Bl2t4TM5PQvzaOM/DuxpzIyak05Gq0JF3sQMT80vj8DTMbdivV+sjX2vpp4HWhNTW5FKcMF2ADYjAAAB9hkkglbLBI+OVnNHsXZUPgBkkbSvFTI4/oV8yz1ysnLrE5PQljA6rw+bjatG5H01+reuz0OYT6x74ntfC9Y3p2KxdlOff46qzlcMtV6ucO+TrrmNjnHB8QtQYjosSz61Cn0J+f7TesPxgoSojMvTkrv73s5ocuzxt0OuS7DWVv3cEqbn013Gay0/kkatXJw7r3PXZTOQzwTJvDPHI3yfuUJ1zh2i1GafR7A+7KDU2PgA28gAfCrbxLSzeqVUVbFmGNqfbegxkxkuRsahluImnMb0kfdSZ6fQi5mkZnjBYl3ZhqSRt7pJf5FqvRX2e1EE9VXD5JhsTxVolksyMijTtV67IR7qjinjscj4MQnrtns6f0EIezWoMrmZFfkbskrV+gi7In3GLREQ6tHioQ5seSlZrm+IGU1Dn8jn7Sz5SwsnPlGnuM+4xgB1klBYRRbb5YAAMAAAAAAAAAApcqIjlVdmp2qVLyRVVdmoY/H0cjrDLsw+BjVzVX52XuRPFV8DHtNksl7orT9jiBq2GlGj0xddenYkROW381OuaFSChShqVY0jghajGMTuRDB6D0jQ0dgoqFFiK/tll75H+Jshy77vUf+xerhhAAERIAAAAAAAAAAAAAAAUTwxzwPimYkkT02Vipuiocx8Z9Apoy2zO4JVZQnk6EkHdGv8jp81biZgU1HovJY9qbyrGr4v7ac0JabNkyOayjlzG5OC9H7C9CTvYpfGk4qn19t8HWrDO3sU2qg25F83bVkje56HVKU0kXgABoAAAAAAAAAUdBN99tneKF1Wu3aq717lmP4SKeAD5M9Gerax1HVTaPKzqn6/Mv4uI2qG/8APovxYakCN0VvtG0bJr5Nw/pK1Rt/XI/8B4y8Q9USclyHQ+DDVQa/h6v6EbetZ9mYt6qz9vpdflbKovci7GKmmnnXeexNK5ftvVSgEigodI0bb7KUajexEKgDY1AAAAAAAAAAAAAAABS+RkbHPkVEYnapa5HI16Me8z/b7mJ2m3cPOGuS1lJHkc6klHCb9JkPY+X+SeZrOcYLMjaMGzAaV03ldfZD1TFotfGRr89bVOXwTxOmtE6RxekMUynioERdvnJV9+RfFVMnhsTSw1COlja7K9aNNkYxC+OZde7f+C7XXsAAIiUAAAAAAAAAAAAAAAAAADbcAA5D416bk0rryS1WZtVuL6xEqdm/00/EtadhlusyWNeSpz8jpjiZo6vrPTklKTZlqP268v2H/wAjklrbulszPjsrE+J7X7SMXu808jpae3fHaU7IGzApY5JGNexUVi9ioVFgrlEUscvS6t6P2XmVmMv41ZHrPRk6mynh2PLCHOy1ZOqyUCoqfTQG2M9GxAt6lyvabvBKi+W/MuAYAABgAAAAAAAAAAAAAAAAAAAAAAFL5GRpvI9GJ5qDJUDFXM7Ug6SMV0r/ACMLPnrlhehXZ1e/cnNQZUGzabNiCq3eeRGfvNeyOo3uRWUmdBv217S3qYa7ef1lp6save/tEOJ+Us3Hi8UnTf8ATkX95htQWX0S1175qC5ZOfBXhZSnx9PUmomeuWZk6yvBJzYxO5VTvUnlrEYiIxERE7EQ5o03LxA0rHDFj8jBdowpslaROW3h4kjaR4prdy0GI1Jjn42/Mu0bt945F8EONK+Ooea5qRenpbtOv3sGiUgADAAAAAAAAAAAAAAAAAAAAAAAAAOYfShZE3V2PejOi99ZOm/x5qdPEUcfNCS6pwseQxrOnkaKL82n1jO9PiS6eahZyRWR4yc9Mx+ZwMTJH11s0JE6aPi5psZOjeguR7wv9rvYvahc8O9YJj0+Rs2qsiRehFJInufqKSNLiMbZ6Mvq0D9+x7U7Svf5ezR2enqIf3R1avDV62v1NPPn6ZHZ426kVuPoTxo9PE3ybS1B7Hox00bl7FR3YYC/ojI/+nZVPhIwmr85o59vBWs/w/ra+YrJH9zATwOWSi9Vb4dinhDmL9J/QnRX7dzzdnaH1I7dFycCJ5Ifa/DKaaXp5TKK5v6iE0/L6OC/iGIeH1s+JVmt1tR15OU7HRr49plIb9af83OxfvMxneHtCOm12LrzPkYnPaTmpHtzE+qT9VO+aq/fZOvZsn4kml8jTqlmBHq/EW6Z4mbmmy9nMGjsbdhusrVZXzyPXZiRLvv8CRcbw74g2ajLDKUSMdzRk8iI/wDAt74xWcnOdbTwWQPW5pjXNBXesadnlb4xbP8A3GOemfgXaxpzJsd/d3/yMxlGRptLwGKfk7MS7T4q9Gv68SoG5pO+naT/AONTJjBlQYh2cYn/ACdr/tqWr9TRJ0kSu/peD+QM7GbCDWH6lk+hXYnxU8X6iuO9yNifBAZ9Nm2bHxz2N7VRPippjr+UsdnWfchUmMydrm9H/wDWoM+mbPNkqcPvzs+CGOsajrt5RRvf5ryLODTUq8550TyQyNfT9OL3+nIvmB+RGIsZ65PyhRGfBN1PFlHI3l3ej1Re96m3w1q8KfNxMb9x67gb8dI12nppidFbUu/kwzdWlXqp8zEieZRNYl36FSnZsy9yMYu34nvW0lqLMbetvjx9ZfoJzUgu1dNCzZPBZp0Wp1L/ACQZic1mGQxrXqr1lh/Ll3G98NtNLh8a+5aT8vspuu6c2J4F1pvQ2LwkrZ9nWbadkknd8ENqe5jGK97msYnaqrsh5XyvmFqF6NHR67xHhPwj9W3s1nM4zUE7ldSzTIG/Y6o0bO0dQ4TI0M5lrMN1tOZj406e2+y77bG25zXdOpN6niY3ZG+9dmMi5pubBonhlmNQ34MzruRY4GL04sen7On4fAn8XHUwxZYkl/xyVfMX6WSdcG3P/ngmfTGWbncBQyccT4m2okk6D+1NzKFEMTIYmRxMRjGJsiJ3IVnQZwV1yAADIAAAAAAAAAAAAAAAAAAAAAAABGnEThFhdWyS3Id6GTenOWJOUi/rp3kcU+H3EHSsbm0X1clVYvKJJOe3ludJDczKe6OyayjEHOue+t4ZzBPrmXFy9RqLCXaMnfvGuxkqWucBb26N9kbvCTkdB26NO7EsduvFMxe1JGoqGnZbhNo3Jqqy4aGJ698CrH+4oy8Zo5/DR1K/Oa2vvDI/ZnsVInsZGsv/AFn1c7ik97IVv+4hmp+AGk5F3ZJejTwSX/I+1eAOkoX7yPvTJ4Pl/wAiH9iab/UZZ/zJd/pmvTamwsKbyZSsm36xgstrTTluJ1fqFyau5JHHFvuSzjuDmiqT+mmJbM7/AO7Irzb8Zp7D4pnQx2MqV2p+jiRCSvxemre7Lf8A4IrfO6mxY2JHPPB/RmTfxBgzKYaehh4t3sSwm23Lbki8zptA1uwOjOe9nGSw22Bsi9yAGoKFijXtjYv3Hz1eD9FH/gQ9ADODyStD+gj/AMCGmcRuHmJ1biZkdVjiyDWKtewxNnovgvihvACbi8o1aTOBcvjbeIyE1LIxPhswv2exUPtLIT1PzLEkb3orNzsDiTw4xmtqm8ierZKNPmrLE5/BfFDnXK6B1hom+thmO9dhReb4Gdax6eadqHShqN647IklnFnRr0OplTlJW2/sJsXCaj6fuU53r5IpsNTW2Gb7GZwSVpk5P+aM1T1vpNE+bSOL/wCLYo2eQ1Ff8hnTp8XpbOfXRpsFzKWl/JcPZfv5bGZx+C1HdcnWU4arO9ZH8zaf9PdPNTlcT4bFvNxH0/Gn9Ykf8GHPn5PyE+K6sHQr8R42HNluf7l3jdKRwpvendYf4JyQzUGPpwJtFWjT7jSLPFLGt6SVKdmZ3dy2PBmsdU5blg9PWHtd2P6pVKM9J5PU/wAQvQ1XidJ/DwSQxGonstRvwQsMjmsfj2qty7DHt3K7ma9S4fcStRrvkrMeLrqvNFfz2+CG6ae4B4Os5s+fuWspY70Vegxf4/tNq/BxjzbZ/wBEN3+I1/Jr/wCzQrGvVvT+qaaxlnI2V5IrI1VDNYXhjq3VsjZ9XXVxlJf+WiXd6p+5CdsNg8Vha7YMVQgqxp3RsRDJLv3HSpop0/8ABjz9s4uo1+p1XFk+PpGraQ4f6d0pGnyVj42z99iT25F+9TagCZyb5ZUSS6AABsAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAqb9oABjMlp3D5Pf1/G1LO/6SJFMBY4YaNnXeTA0vuZsbkDKnJdM12L6NG/om0T/wCw1v2nvBwy0dA/ePA0vvZubkDPqT+zX04fRiKmmsLTa1KuKpRNT7ECIZSKKONNo2MYieCbFYNW2zZJLoAAGwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB//2Q==";
}
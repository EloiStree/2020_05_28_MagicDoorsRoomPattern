// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:5261,x:32719,y:32712,varname:node_5261,prsc:2|emission-9987-OUT;n:type:ShaderForge.SFN_Tex2d,id:4900,x:32063,y:32592,ptovrint:False,ptlb:Lightmaps,ptin:_Lightmaps,varname:node_4900,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:2741f8af34f7ccf4ba4bdf1f20cd804c,ntxv:0,isnm:False|UVIN-9429-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:5987,x:32063,y:32788,ptovrint:False,ptlb:Albedo,ptin:_Albedo,varname:_node_4900_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:f6e89525b29b940488fe410a0e976308,ntxv:0,isnm:False|UVIN-5907-UVOUT;n:type:ShaderForge.SFN_Multiply,id:7451,x:32255,y:32683,varname:node_7451,prsc:2|A-4900-RGB,B-5987-RGB;n:type:ShaderForge.SFN_TexCoord,id:5907,x:31792,y:32799,varname:node_5907,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_TexCoord,id:9429,x:31792,y:32590,varname:node_9429,prsc:2,uv:1,uaff:False;n:type:ShaderForge.SFN_Add,id:9987,x:32534,y:32633,varname:node_9987,prsc:2|A-7451-OUT,B-7505-OUT;n:type:ShaderForge.SFN_Tex2d,id:8395,x:32255,y:32510,ptovrint:False,ptlb:Glowmap,ptin:_Glowmap,varname:node_8395,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:408c33b17a4af2741a426db01be9b809,ntxv:0,isnm:False|UVIN-9429-UVOUT;n:type:ShaderForge.SFN_Color,id:3930,x:32255,y:32349,ptovrint:False,ptlb:Glow Tint,ptin:_GlowTint,varname:node_3930,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.9895096,c2:1,c3:0.7028302,c4:1;n:type:ShaderForge.SFN_Multiply,id:7505,x:32422,y:32426,varname:node_7505,prsc:2|A-3930-RGB,B-8395-RGB;proporder:5987-4900-8395-3930;pass:END;sub:END;*/

Shader "Custom/shd_additiveLightmapped" {
    Properties {
        _Albedo ("Albedo", 2D) = "white" {}
        _Lightmaps ("Lightmaps", 2D) = "white" {}
        _Glowmap ("Glowmap", 2D) = "white" {}
        _GlowTint ("Glow Tint", Color) = (0.9895096,1,0.7028302,1)
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        LOD 200
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _Lightmaps; uniform float4 _Lightmaps_ST;
            uniform sampler2D _Albedo; uniform float4 _Albedo_ST;
            uniform sampler2D _Glowmap; uniform float4 _Glowmap_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _GlowTint)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
////// Lighting:
////// Emissive:
                float4 _Lightmaps_var = tex2D(_Lightmaps,TRANSFORM_TEX(i.uv1, _Lightmaps));
                float4 _Albedo_var = tex2D(_Albedo,TRANSFORM_TEX(i.uv0, _Albedo));
                float4 _GlowTint_var = UNITY_ACCESS_INSTANCED_PROP( Props, _GlowTint );
                float4 _Glowmap_var = tex2D(_Glowmap,TRANSFORM_TEX(i.uv1, _Glowmap));
                float3 emissive = ((_Lightmaps_var.rgb*_Albedo_var.rgb)+(_GlowTint_var.rgb*_Glowmap_var.rgb));
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}

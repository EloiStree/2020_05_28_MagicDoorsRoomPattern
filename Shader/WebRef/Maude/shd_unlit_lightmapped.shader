// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:5625,x:32703,y:32730,varname:node_5625,prsc:2|emission-6033-OUT;n:type:ShaderForge.SFN_Tex2d,id:6250,x:32185,y:32831,ptovrint:False,ptlb:Lightmap,ptin:_Lightmap,varname:_node_4274_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:6a985dfcd1d3ca94e9753748ed65c697,ntxv:0,isnm:False|UVIN-9309-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:5302,x:32185,y:32644,ptovrint:False,ptlb:Albedo,ptin:_Albedo,varname:node_5302,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-9625-UVOUT;n:type:ShaderForge.SFN_Multiply,id:6033,x:32383,y:32739,varname:node_6033,prsc:2|A-5302-RGB,B-6250-RGB;n:type:ShaderForge.SFN_TexCoord,id:9309,x:31965,y:32857,varname:node_9309,prsc:2,uv:1,uaff:False;n:type:ShaderForge.SFN_TexCoord,id:9625,x:31965,y:32668,varname:node_9625,prsc:2,uv:0,uaff:False;proporder:5302-6250;pass:END;sub:END;*/

Shader "Custom/shd_unlit_lightmapped" {
    Properties {
        _Albedo ("Albedo", 2D) = "white" {}
        _Lightmap ("Lightmap", 2D) = "white" {}
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
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _Lightmap; uniform float4 _Lightmap_ST;
            uniform sampler2D _Albedo; uniform float4 _Albedo_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float4 _Albedo_var = tex2D(_Albedo,TRANSFORM_TEX(i.uv0, _Albedo));
                float4 _Lightmap_var = tex2D(_Lightmap,TRANSFORM_TEX(i.uv1, _Lightmap));
                float3 emissive = (_Albedo_var.rgb*_Lightmap_var.rgb);
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

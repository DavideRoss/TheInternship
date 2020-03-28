// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "XRayOutLine_Shader"
{
	Properties
	{
		_ASEOutlineWidth( "Outline Width", Float ) = 0
		_XRayPower("XRayPower", Float) = 0
		_XRayColor("XRayColor", Color) = (0,0,0,0)
		_XRayScale("XRayScale", Float) = 0
		_XRayBias("XRayBias", Float) = 0
		_XRayIntensity("XRayIntensity", Float) = 0
		_Colore("Colore", Color) = (1,0,0,0)
		_Geo_1_textureslambert1_AO("Geo_1_textureslambert1_AO", 2D) = "white" {}
		_Geo_1_textureslambert1_Base_Color("Geo_1_textureslambert1_Base_Color", 2D) = "white" {}
		_Geo_1_textureslambert1_MG("Geo_1_textureslambert1_MG", 2D) = "white" {}
		_Geo_1_textureslambert1_Normal("Geo_1_textureslambert1_Normal", 2D) = "bump" {}
		[Toggle(_KEYWORD0_ON)] _Keyword0("Keyword 0", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0"}
		ZWrite Off
		ZTest Always
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog alpha:fade  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		
		
		
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};
		uniform float _XRayBias;
		uniform float _XRayScale;
		uniform float _XRayPower;
		uniform float4 _XRayColor;
		uniform float _XRayIntensity;
		uniform half _ASEOutlineWidth;
		
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += ( v.normal * _ASEOutlineWidth );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV5 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode5 = ( _XRayBias + _XRayScale * pow( 1.0 - fresnelNdotV5, _XRayPower ) );
			o.Emission = ( fresnelNode5 * _XRayColor ).rgb;
			o.Alpha = ( fresnelNode5 * (_XRayColor).a * _XRayIntensity );
			o.Normal = float3(0,0,-1);
		}
		ENDCG
		

		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+1" "IsEmissive" = "true"  }
		Cull Back
		ZWrite On
		ZTest LEqual
		CGPROGRAM
		#pragma target 3.0
		#pragma shader_feature _KEYWORD0_ON
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Geo_1_textureslambert1_Normal;
		uniform float4 _Geo_1_textureslambert1_Normal_ST;
		uniform sampler2D _Geo_1_textureslambert1_Base_Color;
		uniform float4 _Geo_1_textureslambert1_Base_Color_ST;
		uniform float4 _Colore;
		uniform sampler2D _Geo_1_textureslambert1_MG;
		uniform float4 _Geo_1_textureslambert1_MG_ST;
		uniform sampler2D _Geo_1_textureslambert1_AO;
		uniform float4 _Geo_1_textureslambert1_AO_ST;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			#ifdef _KEYWORD0_ON
				float3 staticSwitch18 = 0;
			#else
				float3 staticSwitch18 = float3( 0,0,0 );
			#endif
			v.vertex.xyz += staticSwitch18;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Geo_1_textureslambert1_Normal = i.uv_texcoord * _Geo_1_textureslambert1_Normal_ST.xy + _Geo_1_textureslambert1_Normal_ST.zw;
			o.Normal = UnpackNormal( tex2D( _Geo_1_textureslambert1_Normal, uv_Geo_1_textureslambert1_Normal ) );
			float2 uv_Geo_1_textureslambert1_Base_Color = i.uv_texcoord * _Geo_1_textureslambert1_Base_Color_ST.xy + _Geo_1_textureslambert1_Base_Color_ST.zw;
			float4 tex2DNode14 = tex2D( _Geo_1_textureslambert1_Base_Color, uv_Geo_1_textureslambert1_Base_Color );
			o.Albedo = tex2DNode14.rgb;
			float4 lerpResult17 = lerp( float4( 0,0,0,0 ) , _Colore , tex2DNode14);
			o.Emission = lerpResult17.rgb;
			float2 uv_Geo_1_textureslambert1_MG = i.uv_texcoord * _Geo_1_textureslambert1_MG_ST.xy + _Geo_1_textureslambert1_MG_ST.zw;
			float4 tex2DNode15 = tex2D( _Geo_1_textureslambert1_MG, uv_Geo_1_textureslambert1_MG );
			o.Metallic = tex2DNode15.r;
			o.Smoothness = tex2DNode15.g;
			float2 uv_Geo_1_textureslambert1_AO = i.uv_texcoord * _Geo_1_textureslambert1_AO_ST.xy + _Geo_1_textureslambert1_AO_ST.zw;
			o.Occlusion = tex2D( _Geo_1_textureslambert1_AO, uv_Geo_1_textureslambert1_AO ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
303;73;1255;656;814.0103;90.55666;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;1;-1358.117,400;Float;False;Property;_XRayPower;XRayPower;0;0;Create;True;0;0;False;0;0;2.21;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-1406.117,320;Float;False;Property;_XRayScale;XRayScale;2;0;Create;True;0;0;False;0;0;1.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1390.117,208;Float;False;Property;_XRayBias;XRayBias;3;0;Create;True;0;0;False;0;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-1278.117,528;Float;False;Property;_XRayColor;XRayColor;1;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;5;-1166.117,256;Float;True;Standard;TangentNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-990.1171,752;Float;False;Property;_XRayIntensity;XRayIntensity;4;0;Create;True;0;0;False;0;0;1.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;7;-1006.117,576;Float;False;FLOAT;3;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-702.1171,256;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-798.1171,464;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;14;-817.0047,-598.1469;Float;True;Property;_Geo_1_textureslambert1_Base_Color;Geo_1_textureslambert1_Base_Color;7;0;Create;True;0;0;False;0;d6a3d3b74288a284885cdb4f1dcd46f0;d6a3d3b74288a284885cdb4f1dcd46f0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;12;-761.6173,-763.3275;Float;False;Property;_Colore;Colore;5;0;Create;True;0;0;False;0;1,0,0,0;0,0.6132076,0.1744579,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OutlineNode;11;-494.1171,240;Float;False;0;True;Transparent;2;7;Back;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;15;-812.9435,-175.1022;Float;True;Property;_Geo_1_textureslambert1_MG;Geo_1_textureslambert1_MG;8;0;Create;True;0;0;False;0;695199da2e7c6e44299a4aae033fda49;695199da2e7c6e44299a4aae033fda49;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;16;-811.2512,-389.2798;Float;True;Property;_Geo_1_textureslambert1_Normal;Geo_1_textureslambert1_Normal;9;0;Create;True;0;0;False;0;b742546f327068a4b907cee9b8cbeb7e;b742546f327068a4b907cee9b8cbeb7e;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;13;-806.0731,23.22375;Float;True;Property;_Geo_1_textureslambert1_AO;Geo_1_textureslambert1_AO;6;0;Create;True;0;0;False;0;43accd1ee07abe842b1defb7d0072a6d;43accd1ee07abe842b1defb7d0072a6d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;17;-15.38369,-393.9204;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;18;-86.28473,206.5813;Float;False;Property;_Keyword0;Keyword 0;10;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;290.6533,-22.16372;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;XRayOutLine_Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;1;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;1;3;0
WireConnection;5;2;2;0
WireConnection;5;3;1;0
WireConnection;7;0;4;0
WireConnection;9;0;5;0
WireConnection;9;1;4;0
WireConnection;8;0;5;0
WireConnection;8;1;7;0
WireConnection;8;2;6;0
WireConnection;11;0;9;0
WireConnection;11;2;8;0
WireConnection;17;1;12;0
WireConnection;17;2;14;0
WireConnection;18;0;11;0
WireConnection;0;0;14;0
WireConnection;0;1;16;0
WireConnection;0;2;17;0
WireConnection;0;3;15;1
WireConnection;0;4;15;2
WireConnection;0;5;13;0
WireConnection;0;11;18;0
ASEEND*/
//CHKSM=15F55076EC60D608BF3A7FFC578EEC92EDC9AFD1